import QtQuick
import qs.Commons
import qs.Ui

// Pomodoro timer. The bar mounts one instance per monitor, so the timer is
// kept as an absolute end time and every change is pushed to all instances;
// only the first instance sends notifications.
BarWidget {
  id: root
  moduleName: "__USER__.pomodoro"

  readonly property int focusMinutes: clampMinutes(setting("focusMinutes", 25))
  readonly property int breakMinutes: clampMinutes(setting("breakMinutes", 5))
  readonly property int longBreakMinutes: clampMinutes(setting("longBreakMinutes", 15))
  readonly property int longBreakEvery: Math.max(1, Math.min(12, Math.round(Number(setting("longBreakEvery", 4)) || 4)))

  // "idle" | "focus" | "break"
  property string phase: "idle"
  property bool running: false
  property double endsAt: 0        // ms since epoch while running
  property int pausedRemaining: 0  // seconds while paused
  property int completed: 0
  property double now: Date.now()

  readonly property int remaining: running
    ? Math.max(0, Math.ceil((endsAt - now) / 1000))
    : pausedRemaining
  readonly property string clock: formatClock(remaining)

  visible: true
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  Translations { id: strings; directory: Qt.resolvedUrl("i18n") }

  function clampMinutes(value) {
    var n = Math.round(Number(value))
    return isFinite(n) ? Math.max(1, Math.min(180, n)) : 25
  }

  function two(n) {
    return (n < 10 ? I18n.formatNumber(0) : "") + I18n.formatNumber(n)
  }

  function formatClock(seconds) {
    return two(Math.floor(seconds / 60)) + ":" + two(seconds % 60)
  }

  function peers() {
    return bar && typeof bar.moduleWidgets === "function" ? bar.moduleWidgets(moduleName) : [root]
  }

  function isLeader() {
    var items = peers()
    return items.length === 0 || items[0] === root
  }

  function snapshot() {
    return { phase: phase, running: running, endsAt: endsAt, pausedRemaining: pausedRemaining, completed: completed }
  }

  function applyState(s) {
    phase = s.phase
    running = s.running
    endsAt = s.endsAt
    pausedRemaining = s.pausedRemaining
    completed = s.completed
    now = Date.now()
  }

  function publish(s) {
    var items = peers()
    for (var i = 0; i < items.length; i++)
      if (items[i] && typeof items[i].applyState === "function") items[i].applyState(s)
    if (items.indexOf(root) < 0) applyState(s)
  }

  function startPhase(next, s) {
    var minutes = next === "focus" ? focusMinutes
      : (s.completed > 0 && s.completed % longBreakEvery === 0 ? longBreakMinutes : breakMinutes)
    s.phase = next
    s.running = true
    s.endsAt = Date.now() + minutes * 60000
    s.pausedRemaining = minutes * 60
    return s
  }

  function toggle() {
    var s = snapshot()
    if (s.phase === "idle") s = startPhase("focus", s)
    else if (s.running) {
      s.pausedRemaining = remaining
      s.running = false
    } else {
      s.endsAt = Date.now() + s.pausedRemaining * 1000
      s.running = true
    }
    publish(s)
  }

  function reset() {
    publish({ phase: "idle", running: false, endsAt: 0, pausedRemaining: 0, completed: completed })
  }

  function advance(notify) {
    var s = snapshot()
    var finishedFocus = s.phase === "focus"
    if (finishedFocus) s.completed += 1
    s = startPhase(finishedFocus ? "break" : "focus", s)
    if (notify && isLeader()) {
      if (finishedFocus)
        Util.execArgv(["omarchy-notification-send", "-g", "󰅶", "-u", "normal",
          strings.t("notify.focusDone"), strings.t("notify.focusDoneBody").arg(I18n.formatNumber(s.pausedRemaining / 60))])
      else
        Util.execArgv(["omarchy-notification-send", "-g", "󰔛", "-u", "normal",
          strings.t("notify.breakDone"), strings.t("notify.breakDoneBody")])
    }
    publish(s)
  }

  function nudge(deltaMinutes) {
    if (phase === "idle") return
    var s = snapshot()
    if (s.running) s.endsAt = Math.max(Date.now() + 1000, s.endsAt + deltaMinutes * 60000)
    else s.pausedRemaining = Math.max(1, s.pausedRemaining + deltaMinutes * 60)
    publish(s)
  }

  Timer {
    interval: 1000
    repeat: true
    running: root.running
    triggeredOnStart: true
    onTriggered: {
      root.now = Date.now()
      // Only the leader advances; it publishes the new phase to its peers.
      if (root.remaining <= 0 && root.isLeader()) root.advance(true)
    }
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    slotSize: Style.bar.statusSlot
    text: root.phase === "break" ? "󰅶" : (root.phase === "focus" ? "󰔟" : "󰔛")
    labelText: root.phase === "idle" || root.vertical ? "" : root.clock
    active: root.phase === "focus" && root.running
    dimmed: root.phase !== "idle" && !root.running
    tooltipText: {
      var head = root.phase === "idle"
        ? strings.t("tooltip.idle").arg(I18n.formatNumber(root.focusMinutes))
        : strings.t(!root.running ? "tooltip.paused" : (root.phase === "focus" ? "tooltip.focus" : "tooltip.break")).arg(root.clock)
      var lines = [head]
      if (root.completed > 0) lines.push(strings.tn("tooltip.done", root.completed).arg(I18n.formatNumber(root.completed)))
      lines.push(strings.t("tooltip.hints"))
      return lines.join("\n")
    }

    onPressed: function(b) {
      if (b === Qt.RightButton) root.reset()
      else if (b === Qt.MiddleButton) { if (root.phase !== "idle") root.advance(false) }
      else root.toggle()
    }
    onWheelMoved: function(delta) { root.nudge(delta > 0 ? 1 : -1) }
  }
}
