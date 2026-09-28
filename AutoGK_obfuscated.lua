local function _a(d)
    local B = {
        stage = "Waiting for the game", finished = false,
        cleanup = nil :: (() -> (boolean?, string?))?,
        error = nil :: string?,
    }
    function B.Status(_va)
        B.stage = _va
        if not B.finished then pcall(d.show, "Dmc | Starting", _va) end
    end
    function B.Load(path)
        B.Status("Loading " .. path)
        local object = d.resolve(path)
        local result, _b
        d.spawn(function()
            local values = table.pack(pcall(d.require, object))
            if not _b then result = values end
        end)
        local deadline = d.now() + 30
        while not result and d.now() < deadline do d.wait() end
        _b = true
        assert(result, "Timed out loading " .. path .. ". The game module did not return within 30 seconds.")
        assert(result[1], "Cannot load " .. path .. ": " .. tostring(result[2]))
        assert(type(result[2]) == "table", "Unexpected module result: " .. path)
        return result[2]
    end
    function B.Run(main)
        B.Status(B.stage)
        local ok, err = pcall(function() d.ready(); main(B) end)
        B.finished = true
        if ok then
            pcall(d.hide)
        else
            local _c = tostring(err)
            local cleanup = B.cleanup
            if cleanup then
                local cleaned, released = pcall(cleanup)
                if not cleaned or released == false then _c = _c .. "\nCleanup incomplete; rejoin before retrying." end
            end
            B.error = _c
            d.warn("[Dmc startup] " .. _c)
            pcall(d.show, "Dmc | Startup failed", _c .. "\n\nSend this error and your executor name when reporting the problem.")
        end
        return ok, err
    end
    return B
end

local function _d()
    local _e, label, _f, _g
    local function _h()
        if _g then _g:Disconnect(); _g = nil end
        if _e then _e:Destroy(); _e = nil end
    end
    local function _i(title, _c)
        if not _e then
            local _j = game:GetService("Players").LocalPlayer
            local _k = _j and _j:FindFirstChildOfClass("PlayerGui")
            if not _k then return end
            _e = Instance.new("ScreenGui")
            _e.Name, _e.ResetOnSpawn, _e.DisplayOrder = "DmcStartup", false, 1000
            local panel = Instance.new("Frame")
            panel.AnchorPoint = Vector2.new(0.5, 0.5)
            panel.Position, panel.Size = UDim2.new(0.5, 0, 0.4, 0), UDim2.new(0.9, 0, 0, 200)
            panel.BackgroundColor3, panel.BorderSizePixel = Color3.fromRGB(16, 16, 15), 0
            panel.Parent = _e
            local size = Instance.new("UISizeConstraint")
            size.MaxSize = Vector2.new(460, 200); size.Parent = panel
            _f = Instance.new("TextLabel")
            _f.Position, _f.Size = UDim2.new(0, 14, 0, 8), UDim2.new(1, -58, 0, 28)
            _f.BackgroundTransparency, _f.TextSize = 1, 16
            _f.TextXAlignment, _f.Font = Enum.TextXAlignment.Left, Enum.Font.GothamMedium
            _f.TextColor3 = Color3.fromRGB(222, 193, 115); _f.Parent = panel
            label = Instance.new("TextBox")
            label.Position, label.Size = UDim2.new(0, 14, 0, 44), UDim2.new(1, -28, 1, -54)
            label.BackgroundTransparency, label.TextSize, label.TextWrapped = 1, 13, true
            label.ClearTextOnFocus, label.TextEditable, label.MultiLine = false, false, true
            label.TextXAlignment, label.TextYAlignment = Enum.TextXAlignment.Left, Enum.TextYAlignment.Top
            label.Font, label.TextColor3 = Enum.Font.Code, Color3.fromRGB(233, 231, 220)
            label.Parent = panel
            local close = Instance.new("TextButton")
            close.Text, close.TextSize = "X", 14
            close.Position, close.Size = UDim2.new(1, -38, 0, 8), UDim2.new(0, 28, 0, 28)
            close.BackgroundColor3, close.TextColor3 = Color3.fromRGB(39, 37, 30), _f.TextColor3
            close.Parent = panel
            _g = close.Activated:Connect(_h)
            _e.Parent = _k
        end
        _f.Text, label.Text = title, _c
    end
    return _i, _h
end

local _l, startupHide = _d()
local _n = _a({
    now = os.clock, wait = function() task.wait(0.05) end, spawn = task.spawn,
    require = require, warn = warn, show = _l, hide = _m,
    ready = function()
        local _o = game:GetService("Players")
        local deadline = os.clock() + 30
        while (not game:IsLoaded() or not _o.LocalPlayer) and os.clock() < deadline do
            _l("Dmc | Starting", "Waiting for the game to finish loading...")
            task.wait(0.1)
        end
        assert(game:IsLoaded() and _o.LocalPlayer, "Game client was not ready after 30 seconds. Join the game before running Dmc.")
        assert(_o.LocalPlayer:WaitForChild("PlayerGui", 30), "PlayerGui is unavailable.")
        _l("Dmc | Starting", "Loading game modules...")
    end,
    resolve = function(path)
        local object = game:GetService("ReplicatedStorage")
        local deadline = os.clock() + 30
        for name in string.gmatch(path, "[^.]+") do
            object = object:WaitForChild(name, math.max(0.01, deadline - os.clock()))
            assert(object, "Missing dependency: " .. path .. ". Run Dmc in the supported game after it loads.")
        end
        return object
    end,
})

_n.Run(function()
                 
                                                                
           
                                                                

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local _p = assert(Players.LocalPlayer, "Run this on the client")
local _q = _p:WaitForChild("PlayerGui", 10)
local _r = "Auto GK 3.2.6 | STR 0.16 | Misc 0.6 | Evaluation 0.2"
local _s = _G
if type(getgenv) == "function" then
    local ok, environment = pcall(getgenv)
    if ok and type(_t) == "table" then _s = _t end
end

                                                                        

                                                                
          
                                                                

local function _u(path)
    local object = ReplicatedStorage
    for name in string.gmatch(path, "[^.]+") do
        object = object:WaitForChild(name, 5)
        assert(object, "Missing dependency: " .. path)
    end
    return object
end

local function _v(path)
    return _n.Load(path)
end

local M = {
    Dive = _v("Modules.Actions.GoalkeeperDive"),
    Assist = _v("Modules.Actions.GoalkeeperDiveAssist"),
    Actions = _v("Modules.Actions.ActionCommands"),
    Protocol = _v("Modules.Actions.ActionRemoteProtocol"),
    Locks = _v("Modules.Actions.ActionLocks"),
    Contacts = _v("Modules.Actions.GoalkeeperActions"),
    Physics = _v("Modules.Ball.Physics"),
    Hitboxes = _v("Modules.Gameplay.HitboxSettings"),
    Prediction = _v("Modules.Gameplay.GoalkeeperPrediction"),
    Match = _v("Modules.Gameplay.MatchSettings"),
    Controllers = _v("Modules.Characters.CharacterControllers"),
    Grounding = _v("Modules.Characters.Grounding"),
    Ragdoll = _v("Modules.Characters.Ragdoll"),
    Renderer = _v("Client.Gameplay.Ball.Renderer"),
    Teams = _v("Client.Gameplay.ActorTeams"),
    Practice = _v("Client.Gameplay.PracticeSession"),
    Movement = _v("Client.Gameplay.Player.Movement"),
    Presentation = _v("Client.Gameplay.Actions.GoalkeeperDivePresentation"),
    Slide = _v("Client.Gameplay.Actions.SlideTackleInput"),
    Dodge = _v("Client.Gameplay.Actions.Dodge"),
    Freeze = _v("Client.Gameplay.KickoffFreeze"),
    Replay = _v("Client.Gameplay.Replay.GoalReplay"),
    Clock = _v("Client.Player.CharacterMotionSmoothing"),
    Keybinds = _v("Modules.Gameplay.Keybinds"),
    Role = _v("Client.Gameplay.Player.GoalkeeperRole"),
    Actors = _v("Modules.Characters.Actors"),
    Motion = _v("Modules.Characters.CharacterMotion"),
}

local _w = _u("Remotes.Ball")
local _x = _w:WaitForChild("Tackle", 5)
local _y = _w:WaitForChild("State", 5)

assert(_x and _y and _q, "Client is not ready")

if type(_s.__AUTO_GK_CLEANUP) == "function" then
    local _z, released, detail = pcall(_s.__AUTO_GK_CLEANUP)
    assert(_z, "Previous Auto GK cleanup threw: " .. tostring(released))
    assert(released == true,
        "Previous Auto GK cleanup was not confirmed: "
            .. tostring(detail or "Older cleanup has no success result; rejoin once before loading this version"))
end

                                                                
                
                                                                

local _aa = {
    Enabled = true,
    PositionAssist = true,
    PreShotCoverage = true,
    CoverageRange = 65,
    CoverageMinimumDepth = 3,
    CoverageLeadSeconds = 0.10,
    CoverageMaximumLead = 2,
    CoverageStartRadius = 0.90,
    CoverageStopRadius = 0.45,
    CoverageUpdateHz = 20,
    UrgentShotSeconds = 0.55,
    PositionMode = "THREATS",
    RespectManualMovement = true,
    HighBallJumps = true,
    JumpThenDive = true,
    DiveFilter = "SMART",
    BackwardRecovery = true,
    PlannerHz = 12,
    CloseShotPlannerHz = 30,
    UISampleHz = 4,
    SampleStep = 0.01,
    PredictionHorizon = 1.10,
    GoalMarginSeconds = 0.045,
    JumpQueueEstimate = 0.05,
    JumpQueueTimeout = 0.45,
    JumpDiveMinimumAge = 0.07,
    JumpRetrySeconds = 0.65,
    HomeDepth = 8,
    HomeRadius = 2.5,
    PositionDeadzone = 0.65,
    SafeLateralReach = 14,
    PositionResponseSeconds = 0.14,
    PositionStartDeadzone = 1.15,
    HomeStopRadius = 1.25,
    TargetChangeDeadzone = 0.20,
    TargetResponseSeconds = 0.16,
    ManualReleaseGrace = 0.18,
    CachedFrameMaxAge = 0.12,
    MissingStateDisplayDelay = 0.40,
    UIStatusDebounce = 0.18,
    UIEventHoldSeconds = 0.50,
    MaxFinalCandidates = 14,
    RuntimeErrorRetrySeconds = 0.25,
    RuntimeErrorLimit = 3,
    Debug = false,
}

local _ab = {
    Requests = 0,
    JumpRequests = 0,
    DiveRequests = 0,
    FlightsActedOn = 0,
    CatchesObserved = 0,
    ActionMatches = 0,
    Rejected = 0,
}

_s.AutoGKConfig = _aa
_s.AutoGKStats = _ab
_s.AUTO_GK_ENABLED = true
_s.AutoGKBuild = _r

                                                                
            
                                                                

local S = {
    alive = true,
    cleanupComplete = false,
    cleaningUp = false,
    cleanupError = nil,
    closeDropdown = nil,
    cancelUITweens = nil,
    releaseOwnedState = nil,
    releaseStriker = nil,
    releaseMisc = nil,
    releaseEvaluation = nil,
    connections = {},
    status = "STARTING",
    detail = "",
    nextActionAt = 0,
    nextJumpAt = 0,
    nextPlanAt = 0,
    queueEstimate = _aa.JumpQueueEstimate,
    jump = nil,
    controller = nil,
    ownedMove = nil,
    moveCharacter = nil,
    lastChar = nil,
    lastFrame = nil,
    nextUIAt = 0,
    pending = nil,
    lastWarning = {},
    catches = {},
    coverageFrame = nil,
    coverageNextAt = 0,
    coverageWrites = 0,
    plannerMilliseconds = 0,
    immediatePlansChecked = 0,
    delayedPlansChecked = 0,
    lastPlanReason = "NONE",
    loopBusy = false,
    runtimeFailures = 0,
    runtimeRetryAt = 0,
    runtimeError = nil,
    countedFlights = {},
    wasKeeper = false,
    manualActionUntil = 0,
    motionLease = nil,
    nextLeaseId = 0,
    orphanedLease = nil,
    uiBusy = false,
    retiredLocks = {},
    retiredMotions = {},
    jumpBlockOwned = false,
    uiClosers = {},
    ownLockAcquires = 0,
    ownLockReleases = 0,
    goalBasis = setmetatable({}, { __mode = "k" }),
    stick = Vector2.zero,
    touches = {},
    focused = true,
    ui = nil,
    allowPositioning = false,
    positionActive = false,
    positionTarget = nil,
    positionKey = nil,
    positionChangedAt = 0,
    manualUntil = 0,
    positionWrites = 0,
    releaseWrites = 0,
    releaseReasons = {},
    lastReleaseReason = "NONE",
    holdStops = 0,
    holdRechecks = 0,
    holdRecheckMisses = 0,
    followupBlocks = 0,
    lastFollowupBlock = nil,
    ballPhase = "STARTING",
    ballInfo = "",
    ballSignature = nil,
    missingSince = nil,
    currentContext = nil,
    observedBallId = nil,
    displayName = "STARTING",
    displayDetail = "",
    displayUntil = 0,
    displayCandidate = nil,
    displayCandidateSince = 0,
    moveLock = "AutoGK.ContactTest."
        .. tostring(math.floor(os.clock() * 1000000)),
}

                                                                                      
local function cleanup()
    if S.cleanupComplete then return true end
    if S.cleaningUp then return false, "Cleanup is already running" end

    S.cleaningUp = true
    S.alive = false
    _s.AUTO_GK_ENABLED = false
    local failures = {}

    local function attempt(label, fn, ...)
        local ok, result, detail = pcall(fn, ...)
        if not ok or result == false then
            failures[#failures + 1] = label .. ": "
                .. tostring(ok and (detail or "release refused") or result)
            return false
        end
        return true
    end

    if S.closeDropdown then attempt("UI close", S.closeDropdown) end
    if S.cancelUITweens then attempt("UI tweens", S.cancelUITweens) end

    if S.releaseMisc then attempt("Miscellaneous", S.releaseMisc) end
    if S.releaseStriker then attempt("Striker hooks", S.releaseStriker) end
    if S.releaseEvaluation then attempt("Evaluation observers", S.releaseEvaluation) end

    if S.releaseOwnedState then
        attempt("Owned state", S.releaseOwnedState, true)
    end

                                                            
    local remaining = {}
    for _, _wb in ipairs(S.connections) do
        if not attempt("Disconnect", function() _wb:Disconnect() end) then
            remaining[#remaining + 1] = _wb
        end
    end
    S.connections = remaining

    if S.ui and attempt("UI destroy", function() S.ui:Destroy() end) then
        S.ui = nil
        S.closeDropdown = nil
        S.cancelUITweens = nil
    end

    if S.loopBusy then
        failures[#failures + 1] = "Main update is still finishing; retry cleanup"
    end

    if S.ownedMove or S.jump or S.jumpBlockOwned or S.motionLease
        or S.controller or next(S.retiredLocks) or next(S.retiredMotions) then
        failures[#failures + 1] = "Owned movement resources remain"
    end

    S.cleanupComplete = #failures == 0
    S.cleanupError = #failures > 0 and table.concat(failures, "; ") or nil
    S.cleaningUp = false

    if S.cleanupComplete then
        _s.__AUTO_GK_CONTROLLER = nil
    else
        warn("[Auto GK] Cleanup incomplete: " .. S.cleanupError)
    end

    return S.cleanupComplete, S.cleanupError
end

_s.__AUTO_GK_CLEANUP = cleanup
_s.StopAutoGK = cleanup
_n.cleanup = cleanup

local function _ac(signal, fn)
    local c = signal:Connect(fn)
    table.insert(S.connections, c)
    return c
end

local function _ad(_c)
    if _aa.Debug then
        print("[Auto GK] " .. _c)
    end
end

local function _ae(key, _c)
    if os.clock() >= (S.lastWarning[key] or 0) then
        S.lastWarning[key] = os.clock() + 4
        warn("[Auto GK] " .. key .. ": " .. tostring(_c))
    end
end

local function _af()
    if not S.displayCandidate then return end

    local clock = os.clock()

    if clock >= S.displayUntil
        and clock - S.displayCandidateSince
            >= _aa.UIStatusDebounce then

        S.displayName = S.status
        S.displayDetail = S.detail
        S.displayCandidate = nil
    end
end

local function _ag(name: string, detail)
    S.status = name
    S.detail = detail or ""

    if S.displayName == name then
        S.displayDetail = S.detail
        S.displayCandidate = nil
        return
    end

    local _ah =
        name == "CATCH OBSERVED"
        or name == "SERVER REJECTED"
        or name == "JUMP QUEUED"
        or name == "CLOSE-RANGE RUSH"
        or string.sub(name, 1, 9) == "DIVE SENT"

    local _ai =
        _ah
        or name == "OFF"
        or name == "NO CHARACTER"
        or name == "WAITING FOR GK"
        or name == "RUNTIME ERROR"
        or name == "MANUAL SLIDE"
        or name == "MANUAL DODGE"
        or name == "RAGDOLL"
        or name == "ROUND TRANSITION"
        or name == "WINDOW UNFOCUSED"

    if _ai then
        S.displayName = name
        S.displayDetail = S.detail
        S.displayCandidate = nil
        S.displayUntil = os.clock()
            + (_ah and _aa.UIEventHoldSeconds or 0)
        return
    end

    if S.displayCandidate ~= name then
        S.displayCandidate = name
        S.displayCandidateSince = os.clock()
    end

    _af()
end

local function flat(v)
    return Vector3.new(v.X, 0, v.Z)
end

local function finite(n)
    return type(n) == "number"
        and n == n
        and math.abs(n) < math.huge
end

local function _aj(v)
    return typeof(v) == "Vector3"
        and finite(v.X)
        and finite(v.Y)
        and finite(v.Z)
end

local function _ak(v, _lo)
    v = flat(v)

    return v.Magnitude > 0.0001
        and v.Unit
        or (_lo or Vector3.new(0, 0, -1))
end

local function now()
    return M.Clock.GetSmoothedServerTime()
end

local function _al()
    if not S.focused
        or UserInputService:GetFocusedTextBox() then
        return true
    end

    for _, key in ipairs({
        Enum.KeyCode.W,
        Enum.KeyCode.A,
        Enum.KeyCode.S,
        Enum.KeyCode.D,
        Enum.KeyCode.Up,
        Enum.KeyCode.Down,
        Enum.KeyCode.Left,
        Enum.KeyCode.Right,
    }) do
        if UserInputService:IsKeyDown(key) then
            return true
        end
    end

    return S.stick.Magnitude > 0.12
        or next(S.touches) ~= nil
end

_ac(UserInputService.InputChanged, function(_sl)
    if _sl.KeyCode == Enum.KeyCode.Thumbstick1 then
        S.stick = Vector2.new(_sl.Position.X, _sl.Position.Y)
    end
end)

_ac(UserInputService.InputBegan, function(_sl)
    if _sl.UserInputType == Enum.UserInputType.Touch then
        S.touches[_sl] = true
    end
end)

_ac(UserInputService.InputEnded, function(_sl)
    S.touches[_sl] = nil

    if _sl.KeyCode == Enum.KeyCode.Thumbstick1 then
        S.stick = Vector2.zero
    end
end)

_ac(UserInputService.WindowFocusReleased, function()
    S.focused = false
    S.stick = Vector2.zero
    table.clear(S.touches)
end)

_ac(UserInputService.WindowFocused, function()
    S.focused = true
    S.manualUntil = os.clock() + _aa.ManualReleaseGrace
    S.nextPlanAt = 0
end)

                                                                
                    
                                                                

local function _am(kind, frame)
    _ab.Requests = _ab.Requests + 1

    if kind == "JUMP" then
        _ab.JumpRequests = _ab.JumpRequests + 1
    elseif kind == "DIVE" then
        _ab.DiveRequests = _ab.DiveRequests + 1
    end

    local key = frame and frame.flightKey

    if key and not S.countedFlights[key] then
        S.countedFlights[key] = true
        _ab.FlightsActedOn = _ab.FlightsActedOn + 1
    end
end

                                                                
                     
                                                                

local function _an()
    S.positionActive = false
    S.positionTarget = nil
    S.positionKey = nil
end

local function _ao(reason)
    S.lastReleaseReason = reason
    S.releaseReasons[reason] =
        (S.releaseReasons[reason] or 0) + 1

    return reason
end

local function _ap(allowWrite)
    local character, owned = S.moveCharacter, S.ownedMove
    _an()

    local function released(reason)
        if S.moveCharacter == character and S.ownedMove == _aq then
            S.ownedMove = nil
            S.moveCharacter = nil
        end
        return reason == "NONE" and reason or _ao(reason)
    end

    if not _aq or _aq.Magnitude == 0 then return released("NONE") end
    if not character or not character.Parent then return released("CHARACTER_GONE") end
    if not allowWrite then return released("YIELD_WITHOUT_WRITE") end

    if _al() and S.focused
        and not UserInputService:GetFocusedTextBox() then
        return released("MANUAL_INPUT")
    end

    local current = M.Controllers.GetMoveCommand(character)
    if current.Magnitude == 0 then return released("ALREADY_ZERO") end
    if current.Unit:Dot(_aq.Unit) <= 0.999 then return released("COMMAND_CHANGED") end

                                                         
    assert(M.Controllers.SetMoveCommand(character, Vector3.zero) ~= false,
        "Automatic movement stop was refused")
    S.releaseWrites = S.releaseWrites + 1
    return released("STOPPED")
end

local function _ar(allowWrite)
    S.lastFrame = nil
    S.allowPositioning = false
    S.coverageFrame = nil
    S.coverageNextAt = 0
    S.nextPlanAt = 0

    _ap(allowWrite)
end

local function _as(lease)
    if not lease or not lease.lockHeld then
        return true
    end

    local ok, err = pcall(
        M.Movement.UnlockMovement,
        lease.lockName
    )

    ok = ok and err ~= false

    if ok then
        lease.lockHeld = false
        S.ownLockReleases = S.ownLockReleases + 1
        S.retiredLocks[lease.lockName] = nil
    else
        S.retiredLocks[lease.lockName] = lease
        _ae("OWN LOCK RELEASE", err)
    end

    return ok
end

local function _at(lease)
    if not lease or not lease.cancelPending then return true end

    local ok, result = pcall(lease.controller.Cancel)
    if ok and result ~= false then
        lease.cancelPending = false
        S.retiredMotions[lease] = nil
        return true
    end

    S.retiredMotions[lease] = true
    _ae("OWN MOTION CANCEL", result)
    return false
end

local function _au(cancel, expected)
    local lease = S.motionLease

    if not lease or (expected and lease ~= expected) then
        return false
    end

    S.motionLease = nil

    local active = lease.controller

    if S.controller == active then
        S.controller = nil
    end

    lease.closed = true

    local _av = true
    if active and cancel then
        lease.cancelPending = true
        _av = _at(lease)
    end

    local _aw = _as(lease)
    return _av and _aw
end

local function _ax()
    for lease in pairs(S.retiredMotions) do
        if os.clock() >= (lease.cancelRetryAt or 0) then
            lease.cancelRetryAt = os.clock() + 1
            _at(lease)
        end
    end

    for _, lease in pairs(S.retiredLocks) do
        if os.clock() >= (lease.retryAt or 0) then
            lease.retryAt = os.clock() + 1
            _as(lease)
        end
    end

    local lease = S.motionLease

    if not lease then return end

    if not lease.root.Parent
        or _p.Character ~= lease.character then
        _au(true, lease)
        return
    end

    if lease.controller
        and type(lease.controller.IsActive) == "function" then

        local ok, active = pcall(lease.controller.IsActive)

        if ok and active == false then
            _au(false, lease)
            return
        end
    end

    if os.clock() >= lease.deadline then
        _ae(
            "OWN MOTION TIMEOUT",
            "Releasing an unfinished automatic dive"
        )

        _au(true, lease)
    end
end

local function _ay()
    local ok, held = pcall(function()
        local _az = M.Keybinds.Get("Jump")

        for _, key in ipairs(_az.KeyCodes or {}) do
            for _, linked in ipairs(
                M.Keybinds.GetLinkedKeyCodes(key)
            ) do
                if M.Keybinds.IsGamepadKeyCode(linked) then
                    if UserInputService:IsGamepadButtonDown(
                        Enum.UserInputType.Gamepad1,
                        linked
                    ) then
                        return true
                    end
                elseif UserInputService:IsKeyDown(linked) then
                    return true
                end
            end
        end

        for _, inputType in ipairs(_az.InputTypes or {}) do
            if inputType == Enum.UserInputType.MouseButton1
                or inputType == Enum.UserInputType.MouseButton2
                or inputType == Enum.UserInputType.MouseButton3 then

                if UserInputService:IsMouseButtonPressed(inputType) then
                    return true
                end
            end
        end

        return false
    end)

    if not ok then
        _ae("JUMP INPUT READ", held)
    end

    return not ok or held == true
end

local function _ba()
    local jump = S.jump
    if jump and jump.latch then
        if not _ay() then
            assert(M.Movement.ReleaseJump() ~= false, "Jump latch release was refused")
        end
        jump.latch = false
    end
    return true
end

local function _bb()
    local _bc = S.jump and S.jump.phase == "QUEUED"

    if not _bc then
        return false
    end

    if not _ay() then
        S.jumpBlockOwned = true

        local ok, err = pcall(
            M.Movement.SetJumpStateBlocked,
            S.moveLock .. ".Queue",
            true
        )

        local released, releaseError = pcall(
            M.Movement.SetJumpStateBlocked,
            S.moveLock .. ".Queue",
            false
        )

        ok = ok and err ~= false
        released = released and _bd ~= false
        S.jumpBlockOwned = not released

        if not ok then
            _ae("JUMP QUEUE CANCEL", err)
        end

        if not released then
            _ae("JUMP QUEUE RELEASE", _bd)
        end

        assert(ok and released, "Queued jump cancellation was not confirmed")
    end

    _ba()
    S.jump = nil

    if S.pending and S.pending.kind == "JUMP" then
        S.pending = nil
    end

    return true
end

local function _be(frame)
    return S.alive
        and _aa.Enabled
        and _s.AUTO_GK_ENABLED
        and S.focused
        and not S.uiBusy
        and frame
        and _p.Character == frame.character
        and frame.humanoid.Health > 0
        and M.Match.IsGoalkeeperCharacter(frame.character)
        and os.clock() >= S.manualActionUntil
end

local function _bf(character, root)
    if next(S.retiredMotions) or next(S.retiredLocks) then
        return "OWN CLEANUP PENDING"
    end

    if M.Controllers.IsSuspended(character) then
        return "CONTROLLER SUSPENDED"
    end

    local _bg

    if type(M.Ragdoll.IsLocallyRagdolled) == "function" then
        _bg = M.Ragdoll.IsLocallyRagdolled(_p)
    elseif type(M.Ragdoll.IsEnabled) == "function" then
                                                                               
                                                                               
        _bg = M.Ragdoll.IsEnabled(character)
    else
        _ae("RAGDOLL API", "Missing IsLocallyRagdolled / IsEnabled; automatic actions paused")
        return "RAGDOLL CHECK UNAVAILABLE"
    end

    if _bg then
        return "RAGDOLL"
    end

    if M.Freeze.IsFrozen() or M.Replay.IsActive() then
        return "ROUND TRANSITION"
    end

    if M.Slide.IsSlideTackling() then
        return "MANUAL SLIDE"
    end

    if M.Dodge.IsDribbling() then
        return "MANUAL DODGE"
    end

    if M.Dive.IsDiveConstraintActive(root) then
        return "DIVE IN PROGRESS"
    end

    if M.Locks.HasGoalkeeperDiveBlock(
        _p,
        M.Renderer.GetVolleyLockUserId()
    ) then
        return "ACTION LOCK"
    end

    if #M.Movement.GetZeroWalkSpeedSources() > 0 then
        return "MOVEMENT LOCK"
    end

    return nil
end

                                                                
                
                                                                

local function _bh(root, state)
    local goal = M.Practice.GetDefendedGoalPart()
    local mode, team, attack = "PRACTICE", nil, nil

    if not goal then
        team = M.Teams.GetActorTeamName(_p)
        if not team then return nil end

        local map = workspace:FindFirstChild("Map")
        local data = map and map:FindFirstChild("Data")
        local _bj = data and data:FindFirstChild(team)

        local _bk = data and data:FindFirstChild(
            M.Match.GetOpposingTeamName(team)
        )

        goal = _bj and _bj:FindFirstChild("Goal")
        _bi = _bk and _bk:FindFirstChild("Goal")
        mode = "MATCH"
    end

    if not (goal and goal:IsA("BasePart")) then
        return nil
    end

    local forward

    if _bi and _bi:IsA("BasePart") then
        forward = _ak(_bi.Position - goal.Position)
    else
        local cached = S.goalBasis[goal]

        if cached and cached.frame == goal.CFrame then
            forward = cached.forward
        else
            local axis = goal.Size.X < goal.Size.Z * 0.5
                and goal.CFrame.RightVector
                or goal.CFrame.LookVector

            forward = _ak(axis)

            local _bl = root.Position - goal.Position

            if math.abs(flat(_bl):Dot(forward)) < 0.3
                and state
                and state.Position then
                _bl = state.Position - goal.Position
            end

            if _bl:Dot(forward) < 0 then
                forward = -forward
            end

            if cached and cached.forward:Dot(forward) < 0 then
                forward = -forward
            end

            S.goalBasis[goal] = {
                frame = goal.CFrame,
                forward = forward,
            }
        end
    end

    return {
        goal = goal,
        team = team,
        mode = mode,
        forward = forward,
        right = Vector3.new(-forward.Z, 0, forward.X),
    }
end

local function _bm(context)
    local goal = context.goal
    local frame, size, axis =
        goal.CFrame, goal.Size, context.right

    return math.max(0.5, (
        math.abs(frame.RightVector:Dot(axis)) * size.X
        + math.abs(frame.UpVector:Dot(axis)) * size.Y
        + math.abs(frame.LookVector:Dot(axis)) * size.Z
    ) * 0.5)
end

                                                                
                
                                                                

local function _bn()
    local ballId = M.Renderer.GetMatchBallId()
    local owner = M.Renderer.GetOwnedUserId()

    if owner ~= nil then
        return {
            phase = "OWNED",
            ballId = ballId,
            owner = owner,
        }
    end

    local state, world = M.Renderer.GetAuthoritativeMovementState()

    if not state or not world then
        local source = M.Renderer.GetTerminalVisualSourceKind()

        return {
            phase = "UNAVAILABLE",
            ballId = ballId,
            source = source,
        }
    end

    if not _aj(state.Position)
        or not _aj(state.Velocity) then
        return {
            phase = "INVALID",
            ballId = ballId,
        }
    end

    return {
        phase = state.VolleyUserId and "VOLLEY" or "MOVEMENT",
        state = state,
        world = world,
        ballId = ballId,

        flightKey = tostring(ballId)
            .. ":"
            .. (finite(state.FlightStartedAt)
                and ("flight:" .. tostring(state.FlightStartedAt))
                or finite(state.ActionId) and ("action:" .. tostring(state.ActionId))
                or ("legacy:" .. tostring(state.StartedAt))),
    }
end

local function _bo(ball, context)
    local mode = context and context.mode or "CLIENT"

    if ball.phase == "OWNED" then
        S.missingSince = nil

        S.ballInfo = ball.owner == _p.UserId
            and "Held by you"
            or "Held by another actor"

        _ag(
            "READY / " .. mode,
            "Ball: " .. S.ballInfo .. "; positioning paused"
        )

    elseif ball.phase == "VOLLEY" then
        S.missingSince = nil
        S.ballInfo = "Volley locked"

        _ag("VOLLEY LOCK / " .. mode, "No automatic action")

    else
        S.missingSince = S.missingSince or os.clock()

        S.ballInfo = ball.phase == "INVALID"
            and "Invalid trajectory"
            or "No movement trajectory"

        if os.clock() - S.missingSince
            >= _aa.MissingStateDisplayDelay then

            _ag(
                "NO BALL STATE / " .. mode,
                S.ballInfo .. "; actions paused"
            )
        else
            _ag(
                "READY / " .. mode,
                "Ball state transition; actions paused"
            )
        end
    end
end

                                                                             
                                                                              
                                                                               
local function _bp(state)
    if not state or not _aj(state.Position) or not _aj(state.Velocity) then
        return nil
    end
    return {
        movementSequence = finite(state.MovementSequence) and state.MovementSequence or nil,
        actionId = finite(state.ActionId) and state.ActionId or nil,
        flightStartedAt = finite(state.FlightStartedAt) and state.FlightStartedAt or nil,
        radius = finite(state.Radius) and state.Radius or nil,
        blockedGoalTeam = state.BlockedGoalTeamName,
    }
end

local function _bq(a, b)
    if a == b then return true end
    if not a or not b then return false end
    return a.movementSequence == b.movementSequence
        and a.actionId == b.actionId
        and a.flightStartedAt == b.flightStartedAt
        and a.radius == b.radius
        and a.blockedGoalTeam == b.blockedGoalTeam
end

local function _br(frame, ball)
    local before, state = frame.sourceTrajectory, ball.state
    if not before or not state then return false end
    if not _aj(state.Position) or not _aj(state.Velocity) then return true end
    local sequence = finite(state.MovementSequence) and state.MovementSequence or nil
    local _bs = finite(state.ActionId) and state.ActionId or nil
    local _bt = finite(state.FlightStartedAt) and state.FlightStartedAt or nil
    local radius = finite(state.Radius) and state.Radius or nil
    return before.movementSequence ~= sequence or before.actionId ~= _bs
        or before.flightStartedAt ~= _bt
        or before.radius ~= radius or before.blockedGoalTeam ~= state.BlockedGoalTeamName
end

local function _bu(value, _lo, low, high)
    return math.clamp(finite(value) and value or _lo, low, high)
end

local function _bv(frame)
                                                                           
                                                                          
    local _bw = frame.plannerAnchor or frame.readClock
    local _bx = _bu(_aa.PlannerHz, 12, 1, 120)
    local _by = math.max(_bx, _bu(_aa.CloseShotPlannerHz, 30, 1, 120))
    local _bz = _bu(_aa.UrgentShotSeconds, 0.55, 0.01, 2)
    local _ca = finite(frame.eta) and frame.eta <= _bz and _by or _bx
    local deadline = _bw + 1 / _ca
    if finite(frame.launchAt) then deadline = math.min(deadline, frame.launchAt) end
    return deadline
end

local function _cb(frame, plan)
    frame.launchAt = plan and plan.kind == "DIVE" and finite(plan.delay)
        and plan.delay > 0 and frame.readClock + plan.delay or nil
end

local function _cc(character, root, humanoid)
    local _cd = os.clock()
    local ball = _bn()

    if ball.phase ~= "MOVEMENT" then
        return nil, ball.phase, ball
    end

    local state, world = ball.state, ball.world
    local _ce = _bp(state)
    local context = _bh(root, state)

    if not context then
        return nil, "WAITING FOR TEAM / GOAL"
    end

    local _cf = now()

    if not finite(_cf) then
        return nil, "CLOCK UNAVAILABLE"
    end

    if finite(state.UpdatedAt)
        and state.UpdatedAt > _cf + 0.10 then
        return nil, "WAITING FOR STATE TIME"
    end

    if finite(state.UpdatedAt) then
        _cf = math.max(_cf, state.UpdatedAt)
    end

    local current = M.Physics.GetStateAtTime(
        state,
        _cf,
        world,
        {}
    )

    if typeof(current) ~= "table"
        or not _aj(current.Position)
        or not _aj(current.Velocity) then
        return nil, "INVALID PREDICTED STATE"
    end

    local radius = current.Radius or M.Physics.BallRadius

    if not finite(radius) or radius <= 0 then
        return nil, "INVALID BALL RADIUS"
    end

    local position, _cg

    if not (
        context.team
        and state.BlockedGoalTeamName == context.team
        and type(M.Match.AreOwnGoalsEnabled) == "function"
        and not M.Match.AreOwnGoalsEnabled()
    ) then
        position, crossingTime = M.Prediction.GetGoalCrossing(
            current,
            world,
            context.goal,
            _cf,
            M.Prediction.Constants.GoalCrossingMaximumPredictionSeconds
        )
    end

    if position ~= nil
        and (not _aj(position) or not finite(_cg)) then
        return nil, "INVALID GOAL CROSSING"
    end

    local _ch = M.Controllers.IsLanded(character, humanoid)
    local _ci = M.Controllers.GetHumanoidState(character, humanoid)
    local _cj = _ci == Enum.HumanoidStateType.Jumping
        or _ci == Enum.HumanoidStateType.Freefall
    local floorY = M.Grounding.GetStandingY(humanoid, root)

    if not finite(floorY) then
        floorY = root.Position.Y
    end

    local _ck = humanoid.UseJumpPower
        and humanoid.JumpPower
        or math.sqrt(math.max(
            0,
            2 * workspace.Gravity * humanoid.JumpHeight
        ))

    local _cl = flat(
        M.Controllers.GetLocomotionVelocity(character, humanoid)
    )

    return {
        character = character,
        root = root,
        humanoid = humanoid,
        rootCF = root.CFrame,
        velocity = root.AssemblyLinearVelocity,
        movementVelocity = _cl,
        floorY = floorY,
        landed = _ch,
        receiveAirborne = _cj,
        jumpSpeed = _ck,
        gravity = workspace.Gravity,
        state = current,
        world = world,
        at = _cf,
        readClock = _cd,
        sourceTrajectory = _ce,
        launchAt = nil,
        context = context,
        ballId = ball.ballId,
        flightKey = ball.flightKey,
        goalPosition = position,
        goalTime = _cg,

        eta = position
            and finite(_cg)
            and _cg - _cf
            or nil,

        radius = radius,
    }
end

                                                                
                    
                                                                

local function _cm(f, t)
    local dy = 0

    if not f.landed then
        dy = math.max(
            f.floorY - f.rootCF.Position.Y,
            f.velocity.Y * t - 0.5 * f.gravity * t * t
        )
    end

    return f.rootCF
        + f.movementVelocity * t
        + Vector3.new(0, dy, 0)
end

                                                                               
                                                                 
local function _cn(f)
    if not f.receiveAirborne then return 0 end

    local height = math.max(0, f.rootCF.Position.Y - f.floorY)
    local velocity = f.velocity.Y

    if f.gravity > 0 then
        local speed = math.sqrt(velocity * velocity + 2 * f.gravity * height)

                                                                             
        if velocity < 0 then
            return 2 * height / (speed - velocity)
        end

        return (velocity + speed) / f.gravity
    end

    return velocity < 0 and height / -velocity or math.huge
end

local function _co(f, t, queueDelay)
    local elapsed = math.max(0, t - queueDelay)

    local rise = math.max(
        0,
        f.jumpSpeed * elapsed
            - 0.5 * f.gravity * elapsed * elapsed
    )

    return f.rootCF
        + f.movementVelocity * t
        + Vector3.new(0, rise, 0)
end

local function _cp(f, plan, t)
    local elapsed = math.max(0, t - plan.delay)
    local assist = plan.assist

    local distance = M.Dive.Constants.Distance
        + (assist and assist.ExtraDistance or 0)

    local scale = assist and assist.TravelScale or 1

    local vertical = assist
        and assist.InitialVerticalVelocity
        or M.Dive.Constants.InitialVerticalVelocity

    local gravity = assist
        and assist.Gravity
        or M.Dive.Constants.GravityStudsPerSecondSquared

    local direction = plan.direction

    if assist and assist.YawRadians ~= 0 then
        direction = M.Dive.RotateFlatDirection(
            direction,
            assist.YawRadians
        )
    end

    local travel = M.Dive.GetTravel(elapsed * scale, distance)

    local rise = vertical * elapsed
        + 0.5 * gravity * elapsed * elapsed

    rise = math.max(
        f.floorY - plan.origin.Position.Y,
        rise
    )

    return plan.origin
        + direction * travel
        + Vector3.new(0, rise, 0)
end

local function _cq(f, plan, t)
    if plan.kind == "HOLD" then
        return _cm(f, t)
    end

    if plan.kind == "JUMP" then
        return _co(f, t, plan.queueDelay)
    end

    return _cp(f, plan, t)
end

local function _cr(f, horizon)
    local points = {
        { t = 0, p = f.state.Position },
    }

    if not finite(horizon) or horizon <= 0 then
        return points
    end

    local step = math.clamp(
        _aa.SampleStep,
        0.0025,
        0.025
    )

    if f.eta and f.eta <= _aa.UrgentShotSeconds then
        step = math.min(step, 0.005)
    end

    local a, b, state = {}, {}, f.state
    local _cs = false
    local t = 0

    while t < horizon - 0.000001 do
        t = math.min(horizon, t + step)

        if not _cs then
            local _ct = state == a and b or a

            state = M.Physics.GetStateAtTime(
                state,
                f.at + t,
                f.world,
                _ct
            )

                                                                           
                                                                               
            _cs = state.Mode == "Resting"
                and type(M.Physics.IsStateSettled) == "function"
                and M.Physics.IsStateSettled(state, f.world)
        end

        points[#points + 1] = {
            t = t,
            p = state.Position,
        }
    end

    return points
end

local function _cu(source, amount)
    return {
        Size = source.Size
            + Vector3.new(amount, amount, amount),

        CFrameOffset = source.CFrameOffset,
        Shape = source.Shape,
    }
end

local function _cv(f, plan, airborne)
    if plan.kind == "HOLD" then
        return M.Hitboxes.ExtendToFeet(
            airborne and M.Hitboxes.AirReceive or M.Hitboxes.Receive,
            f.humanoid,
            f.root
        )
    end

    if plan.kind == "JUMP" then
        return _cu(
            M.Hitboxes.AirReceive,
            f.radius * 2
        )
    end

    local padding = math.max(
        M.Contacts.Constants.ContactPadding or 1.25,
        f.radius * 2
    )

    return _cu(M.Hitboxes.AirReceive, padding)
end

                                                                
                                       
                                                                

                                                                         
                                                                               
                                                                           
                                                                                 
local function _cw(f, plan)
    local box = M.Hitboxes.AirReceive
    local padding = M.Contacts.Constants.ContactPadding or 1.25
    if not box or not _aj(box.Size)
        or box.Size.X <= 0 or box.Size.Y <= 0 or box.Size.Z <= 0
        or not finite(padding) or padding < 0
        or not finite(f.radius) or f.radius <= 0
        or typeof(box.CFrameOffset) ~= "CFrame"
        or not _aj(box.CFrameOffset.Position)
        or typeof(plan.origin) ~= "CFrame"
        or not _aj(plan.origin.Position) then
        return nil, nil
    end

    padding = math.max(1.25, padding, f.radius * 2)
    local half = (box.Size + Vector3.new(padding, padding, padding)) * 0.5
    local basis = plan.origin * box.CFrameOffset
    local right, _cx, look = basis.RightVector, basis.UpVector, basis.LookVector
    local offset = plan.origin:VectorToWorldSpace(box.CFrameOffset.Position)
    if not _aj(right) or not _aj(_cx)
        or not _aj(_cy) or not _aj(offset) then
        return nil, nil
    end

                                                                               
    local p = plan.origin.Position
    local _cz = 0.01 + math.max(math.abs(p.X), math.abs(p.Y), math.abs(p.Z)) * 0.000001
    local extent = Vector3.new(
        math.abs(right.X) * half.X + math.abs(_cx.X) * half.Y + math.abs(_cy.X) * half.Z + _cz,
        math.abs(right.Y) * half.X + math.abs(_cx.Y) * half.Y + math.abs(_cy.Y) * half.Z + _cz,
        math.abs(right.Z) * half.X + math.abs(_cx.Z) * half.Y + math.abs(_cy.Z) * half.Z + _cz
    )
    if not _aj(extent) then return nil, nil end
    return offset, extent
end

local function _da(f, plan, points, requireContact)
    local first =
        (plan.kind == "DIVE" or plan.kind == "JUMP_DIVE")
            and plan.delay
        or (
            plan.kind == "JUMP"
                and plan.queueDelay + _aa.SampleStep
                or 0
        )

    local last = math.min(
        f.eta - _aa.GoalMarginSeconds,

        (plan.kind == "DIVE" or plan.kind == "JUMP_DIVE")
            and plan.delay + M.Dive.Constants.HitboxCurveSeconds
            or _aa.PredictionHorizon
    )

    if plan.kind == "JUMP" and f.gravity > 0 then
        last = math.min(
            last,
            plan.queueDelay + 2 * f.jumpSpeed / f.gravity
        )
    end

    if last <= first then return nil end

    local _db = _cv(f, plan)
    local _dc = plan.kind == "HOLD" and _cn(f) or 0
    local _dd = _dc > 0 and _cv(f, plan, true) or nil
    local contact, _de, deepest = nil, math.huge, 0
    local previousRoot, previousTime
    local _dg = plan.kind == "DIVE" or plan.kind == "JUMP_DIVE"
    local _dh, _di
    local _dj
    if _dg then
        _dh, boundExtent = _cw(f, plan)
                                                                                    
        _dj = { BallRadius = f.radius }
    end

    for i = 2, #points do
        local left, right = points[i - 1], points[i]

        if right.t > first and left.t < last then
            local _dk = math.max(first, left.t)
            local _dl = math.min(last, right.t)

            while _dk < _dl do
                local airborne = _dd ~= nil and _dk < _dc
                local _dm = airborne and math.min(_dl, _dc) or _dl
                local box = airborne and _dd or _db
                                                                             
                                                                              
                local width = right.t - left.t

                local _dn = left.p:Lerp(
                    right.p,
                    (_dk - left.t) / width
                )

                local _do = left.p:Lerp(
                    right.p,
                    (_dm - left.t) / width
                )

                local _dp = previousTime == _dk and previousRoot or _cq(f, plan, _dk)
                local _dq = _cq(f, plan, _dm)
                previousRoot, previousTime = _dq, _dm
                local _dr = _do.Y - _dq.Position.Y
                local _ds
                local _dt = true
                                                                                  
                                                                               
                                                                                  
                if _di and _dh then
                    _ds = _do - _dq.Position - _dh
                    local dx = math.max(math.abs(_ds.X) - _di.X, 0)
                    local dy = math.max(math.abs(_ds.Y) - _di.Y, 0)
                    local dz = math.max(math.abs(_ds.Z) - _di.Z, 0)
                    local _du = math.max(_de, 0.0001)
                    _dt = not (dx * dx + dy * dy + dz * dz > _du * _du)
                end

                if _dt and (not _dg
                    or _dr
                        <= M.Dive.Constants.MaximumSaveHeight) then

                    local _dv, localPoint =
                        M.Hitboxes.GetMissVector(
                            _dq * box.CFrameOffset,
                            box,
                            _do
                        )

                    _de = math.min(_de, _dv.Magnitude)

                    if _dv.Magnitude < 0.0001 then
                        local h = box.Size * 0.5

                        local _dx = math.sqrt(
                            (_dw.X / h.X) ^ 2
                            + (_dw.Z / h.Z) ^ 2
                        )

                        _df = math.max(
                            _df,
                            1 - math.max(
                                _dx,
                                math.abs(_dw.Y / h.Y)
                            )
                        )
                    end
                end

                local alpha

                if _dg then
                                                                                
                                                                                    
                    local possible = not contact or _dk < contact
                    if possible and _di and _dh and _ds then
                        local a = _dn - _dp.Position - _dh
                        local b, h = _ds, _di
                                                                                
                                                                                   
                        possible = not (
                            (a.X > h.X and b.X > h.X) or (a.X < -h.X and b.X < -h.X)
                            or (a.Y > h.Y and b.Y > h.Y) or (a.Y < -h.Y and b.Y < -h.Y)
                            or (a.Z > h.Z and b.Z > h.Z) or (a.Z < -h.Z and b.Z < -h.Z)
                        )
                    end
                    if possible and _dj then
                        _dj.StartRootCFrame = _dp
                        _dj.EndRootCFrame = _dq
                        local hit = M.Contacts.FindDiveSaveContact(
                            _p,
                            _dn,
                            _do,
                            _dj
                        )
                        alpha = hit and hit.Alpha
                    end
                else
                    alpha = M.Hitboxes.GetSegmentEnterAlpha(
                        { CFrame = _dq },
                        box,
                        _dn + _dq.Position - _dp.Position,
                        _do
                    )
                end

                if finite(alpha) and alpha >= 0 and alpha <= 1 then
                    local time = _dk + (_dm - _dk) * alpha

                    if (not airborne or time < _dc)
                        and time < f.eta
                            - _aa.GoalMarginSeconds
                            - 0.000001 then

                        contact = contact
                            and math.min(contact, time)
                            or time

                        _de = 0
                    end
                end

                _dk = _dm
            end
        end

        if right.t >= last then
            break
        end
    end

    if requireContact and not contact then
        return nil
    end

    if _de == math.huge then
        return nil
    end

    return {
        time = contact,
        miss = _de,
        clearance = math.max(0, _df),
    }
end

local function _dy(f)
    local filter = _aa.DiveFilter
    local result

    if filter == "FORWARD" then
        result = { "F" }
    elseif filter == "LEFT" then
        result = { "L", "LF" }
    elseif filter == "RIGHT" then
        result = { "R", "RF" }
    elseif filter == "SIDES" then
        result = { "L", "R" }
    else
        result = { "F", "L", "R", "LF", "RF" }
    end

    if _aa.BackwardRecovery
        and (filter == "SMART" or filter == "ALL") then

        local _dz =
            (f.state.Position - f.rootCF.Position)
                :Dot(f.context.forward) < -1

        local high =
            f.state.Position.Y - f.rootCF.Position.Y
                > M.Hitboxes.AirReceive.Size.Y * 0.5

        if _dz
            or high
            or (f.eta and f.eta <= _aa.UrgentShotSeconds) then

            table.insert(result, "B")
            table.insert(result, "LB")
            table.insert(result, "RB")
        end
    end

    return result
end

local function _ea(f, kind, _gn, name)
    local basis = CFrame.lookAt(
        f.rootCF.Position,
        f.rootCF.Position + f.context.forward
    )

    local choice = M.Dive.GetDirectionChoiceByName(name)

    local origin = kind == "JUMP_DIVE"
        and _co(f, _gn, S.queueEstimate)
        or _cm(f, _gn)

    return {
        kind = kind,
        delay = _gn,
        name = name,
        choice = choice,

        direction = M.Dive.GetWorldDirection(
            choice,
            basis,
            f.context.forward
        ),

        origin = origin,
        basis = basis,
        queueDelay = S.queueEstimate,
    }
end

local function _eb(plan, hit)
    if plan.kind == "HOLD" then
        return -10
    end

    local _ec = plan.kind == "JUMP_DIVE"
        and 2
        or (plan.kind == "JUMP" and 0.9 or 1)

    if plan.name == "B"
        or plan.name == "LB"
        or plan.name == "RB" then
        _ec = _ec + 0.18
    end

    return _ec
        + plan.delay * 0.8
        - hit.clearance * 0.7
        + hit.time * 0.05
end

local function _ed(f, plan)
    local _ee = {
        CFrame = plan.origin,
        Position = plan.origin.Position,
    }

    local assist = M.Assist.GetAssist(
        f.state,
        f.world,
        _ee,
        plan.direction,
        f.at + plan.delay
    )

    if not assist then return nil end

    assist = table.clone(assist)

    if plan.kind == "DIVE" and plan.delay == 0 then
        M.Assist.DropBlockedLaunchYaw(
            f.root,
            plan.direction,
            assist
        )
    end

    return assist
end

local function _ef(f, kind, _gn, name, points, prepared)
    local _eg = prepared or _ea(f, kind, _gn, name)
    _eg.useAssist = false

    local hit
    if prepared then
                                                                              
                                                                                 
        hit = _eg.rawContact
        _eg.rawContact = nil
        if hit and not hit.time then hit = nil end
    else
        hit = _da(f, _eg, points, true)
    end
    local best

    if hit then
        _eg.contact = hit
        _eg.score = _eb(_eg, hit)
        best = _eg
    end

    local assist = _ed(f, _eg)

    if assist then
        local corrected = table.clone(_eg)

        corrected.assist = assist
        corrected.useAssist = true

        local _eh = _da(
            f,
            corrected,
            points,
            true
        )

        if _eh then
            corrected.contact = _eh
            corrected.score = _eb(corrected, _eh)

            if not best
                or corrected.score < best.score - 0.001 then
                best = corrected
            end
        end
    end

    return best
end

local function _ei(candidates)
    table.sort(candidates, function(a, b)
        if a.score ~= b.score then
            return a.score < b.score
        end

        if a.contact.time ~= b.contact.time then
            return a.contact.time < b.contact.time
        end

        return tostring(a.name or a.kind)
            < tostring(b.name or b.kind)
    end)

    return candidates[1]
end

                                                                           
                                                                            
                                                                             
                                                                              
local function _ej(f, points, horizon)
    local assist = M.Assist and M.Assist.Constants
    local dive = M.Dive.Constants
    local box = M.Hitboxes.AirReceive
    local _ek = assist and assist.MaximumExtraReachStuds
    local distance = dive and dive.Distance
    local padding = M.Contacts.Constants.ContactPadding or 1.25

    if not finite(_ek) or _ek < 0
        or not finite(distance) or distance < 0
        or not finite(padding) or padding < 0
        or not finite(f.radius) or f.radius <= 0
        or not finite(horizon) or horizon <= 0
        or not _aj(f.rootCF.Position)
        or not _aj(f.movementVelocity)
        or not box or not _aj(box.Size)
        or box.Size.X <= 0 or box.Size.Y <= 0 or box.Size.Z <= 0
        or typeof(box.CFrameOffset) ~= "CFrame"
        or not _aj(box.CFrameOffset.Position)
        or #points < 2 then
        return true
    end

                                                                                
    padding = math.max(1.25, padding, f.radius * 2)
    local _el = box.Size + Vector3.new(padding, padding, padding)
    local _em = distance + _ek + _el.Magnitude * 0.5
        + box.CFrameOffset.Position.Magnitude + 0.05
    local start = f.rootCF.Position
    local finish = start + f.movementVelocity * horizon
    if not finite(_em) or not _aj(finish) then return true end

    local _en, maxX = math.huge, -math.huge
    local _ep, maxZ = math.huge, -math.huge
    for _, point in ipairs(points) do
        local p = point.p
        if not _aj(p) then return true end
        _en, maxX = math.min(_en, p.X), math.max(_eo, p.X)
        _ep, maxZ = math.min(_ep, p.Z), math.max(_eq, p.Z)
    end

                                                                           
                                                                               
    return not (_eo < math.min(start.X, finish.X) - _em
        or _en > math.max(start.X, finish.X) + _em
        or _eq < math.min(start.Z, finish.Z) - _em
        or _ep > math.max(start.Z, finish.Z) + _em)
end

local function _er(f)
    local began = os.clock()

    S.immediatePlansChecked = 0
    S.delayedPlansChecked = 0

    local function finish(plan, reason)
        S.plannerMilliseconds = (os.clock() - began) * 1000

        S.lastPlanReason = reason
            or (plan and plan.kind)
            or "NO PRE-GOAL CONTACT"

        return plan, reason
    end

    local horizon = math.min(
        _aa.PredictionHorizon,
        f.eta - _aa.GoalMarginSeconds
    )

    if horizon <= 0.0001 then
        return finish(nil, "TOO LATE")
    end

    local points = _cr(f, horizon)
    local _es = { kind = "HOLD", delay = 0 }
    local _et = f

    if S.ownedMove then
        _et = table.clone(f)
        _et.movementVelocity = Vector3.zero
    end

    local _eu = _da(
        _et,
        _es,
        points,
        true
    )

    if _eu then
        _es.contact = _eu
        _es.score = _eb(_es, _eu)

        return finish(_es)
    end

    if S.jump and not _aa.JumpThenDive then
        return finish(nil, "JUMP ONLY / RECOVERY")
    end

    local candidates = {}

    local _ev =
        _aa.HighBallJumps
        and not S.jump
        and f.landed
        and os.clock() >= S.nextJumpAt
        and f.jumpSpeed > 0

    if _ev then
        local jump = {
            kind = "JUMP",
            delay = 0,
            queueDelay = S.queueEstimate,
        }

        local hit = _da(f, jump, points, true)

        if hit then
            jump.contact = hit
            jump.score = _eb(jump, hit)
            candidates[#candidates + 1] = jump
        end
    end

    if not _ej(f, points, horizon) then
        local plan = _ei(candidates)
        return finish(plan, not plan and "OUTSIDE DIVE REACH" or nil)
    end

    local _ew = _dy(f)

    for _, name in ipairs(_ew) do
        S.immediatePlansChecked =
            S.immediatePlansChecked + 1

        local plan = _ef(
            f,
            "DIVE",
            0,
            name,
            points,
            nil
        )

        if plan then
            candidates[#candidates + 1] = plan
        end
    end

    if #candidates > 0 then
        return finish(_ei(candidates))
    end

    local possible = {}

    local function _ex(kind, _gn, name)
        if _gn >= horizon - 0.005 then
            return
        end

        local plan = _ea(f, kind, _gn, name)
        local _ey = _da(f, plan, points, false)

        if _ey then
            plan.rawMiss = _ey.miss
            plan.rawContact = _ey
            possible[#possible + 1] = plan
        end
    end

    for _, name in ipairs(_ew) do
        for _, _gn in ipairs({ 0.05, 0.10, 0.20, 0.30 }) do
            _ex("DIVE", _gn, name)
        end

        if _ev and _aa.JumpThenDive then
            for _, age in ipairs({ 0.10, 0.18, 0.26 }) do
                _ex(
                    "JUMP_DIVE",
                    S.queueEstimate + age,
                    name
                )
            end
        end
    end

    table.sort(possible, function(a, b)
        local _ez = a.rawMiss
            + (a.kind == "JUMP_DIVE" and 0.10 or 0)
            + a.delay * 0.2

        local _fa = b.rawMiss
            + (b.kind == "JUMP_DIVE" and 0.10 or 0)
            + b.delay * 0.2

        if _ez ~= _fa then
            return _ez < _fa
        end

        return a.name < b.name
    end)

    local _fb = false

    for _, _of in ipairs(possible) do
        if S.delayedPlansChecked >= _aa.MaxFinalCandidates then
            _fb = true
            break
        end

        S.delayedPlansChecked = S.delayedPlansChecked + 1

        local plan = _ef(
            f,
            _of.kind,
            _of.delay,
            _of.name,
            points,
            _of
        )

        if plan then
            candidates[#candidates + 1] = plan
        end
    end

    if #candidates > 0 then
        return finish(_ei(candidates))
    end

    return finish(
        nil,
        _fb
            and "NO CONTACT / SEARCH LIMIT"
            or "NO PRE-GOAL CONTACT"
    )
end

                                                                
                    
                                                                

local function _fc(f, plan)
    if not _aa.HighBallJumps then return false end

    if plan.kind == "JUMP_DIVE"
        and not _aa.JumpThenDive then
        return false
    end

    if not _be(f) or _ay() then
        return false
    end

    if S.ownedMove then
        _ap(true)
        S.nextPlanAt = 0

        _ag(
            "SETTLING FOR JUMP",
            "Rechecking position after walking"
        )

        return false
    end

    local fresh = _cc(f.character, f.root, f.humanoid)

    if fresh and not _bq(f.sourceTrajectory, fresh.sourceTrajectory) then
        S.lastFrame = nil
        S.nextPlanAt = 0
        _ag("REPLAN JUMP", "Trajectory changed before launch")
        return false
    end

    if not fresh
        or not fresh.eta
        or fresh.eta <= 0
        or fresh.flightKey ~= f.flightKey
        or fresh.context.goal ~= f.context.goal
        or fresh.context.team ~= f.context.team
        or not fresh.landed
        or fresh.jumpSpeed <= 0
        or S.jump
        or os.clock() < S.nextJumpAt then
        return false
    end

    local _fd

    if plan.kind == "JUMP_DIVE" then
        _fd = _ea(
            fresh,
            "JUMP_DIVE",
            plan.delay,
            plan.name
        )

        if plan.useAssist then
            _fd.assist = _ed(fresh, _fd)
        end
    else
        _fd = {
            kind = "JUMP",
            delay = 0,
            queueDelay = S.queueEstimate,
        }
    end

    local horizon = math.min(
        _aa.PredictionHorizon,
        fresh.eta - _aa.GoalMarginSeconds
    )

    if horizon <= 0.0001 then return false end

    local hit = _da(
        fresh,
        _fd,
        _cr(fresh, horizon),
        true
    )

    if not hit then
        _ag("REPLAN JUMP", "No modeled pre-goal contact")
        return false
    end

    f, plan = fresh, _fd
    plan.contact = hit

    local _fe =
        M.Controllers.CreateNativeJumpImpulseReader(f.character)

    if not _aa.HighBallJumps
        or (
            plan.kind == "JUMP_DIVE"
            and not _aa.JumpThenDive
        ) then
        return false
    end

    if not _be(f)
        or _bf(f.character, f.root)
        or _ay()
        or S.jump
        or os.clock() < S.nextJumpAt
        or not M.Controllers.IsLanded(f.character, f.humanoid) then
        return false
    end

    local _ff, requested = pcall(M.Movement.Jump)

    S.nextJumpAt = os.clock() + _aa.JumpRetrySeconds

    if not _ff or not _fg then
        if not _ay() then
            pcall(M.Movement.ReleaseJump)
        end

        if not _ff then
            _ae("JUMP REQUEST", _fg)
        end

        _ag(
            "JUMP REFUSED",
            "Existing jump state or input block"
        )

        return false
    end

    S.jump = {
        phase = "QUEUED",
        requested = os.clock(),
        reader = _fe,
        character = f.character,
        root = f.root,
        initialY = f.root.Position.Y,
        flightKey = f.flightKey,
        latch = true,
        planned = plan.kind,
    }

    _am("JUMP", f)

    S.pending = {
        kind = "JUMP",
        at = os.clock(),
        ballId = f.ballId,
        flight = f.flightKey,
    }

    _ag("JUMP QUEUED", "Waiting for actual takeoff")

    _ad(string.format(
        "JUMP QUEUED | %s | modeled contact %.3fs | goal %.3fs",
        plan.kind,
        plan.contact.time,
        f.eta
    ))

    return true
end

local function _fh(character, root, humanoid)
    local j = S.jump
    if not j then return false end

    if j.character ~= character or not root.Parent then
        _ba()
        S.jump = nil
        return false
    end

    if j.phase == "QUEUED" then
        local impulse

        if j.reader then
            impulse = j.reader()
        else
            impulse =
                root.AssemblyLinearVelocity.Y > 1
                and root.Position.Y > j.initialY + 0.035
                and not M.Controllers.IsLanded(
                    character,
                    humanoid
                )
        end

        if impulse then
            j.phase = "AIRBORNE"
            j.launched = os.clock()

            local _fi = math.max(
                0,
                j.launched - j.requested
            )

            local _fj = math.clamp(
                _fi,
                0.015,
                0.20
            )

            S.queueEstimate =
                S.queueEstimate * 0.7
                + _fj * 0.3

            _ba()

            _ad(string.format(
                "JUMP AIRBORNE | sampled delay %.3fs"
                    .. " | planning estimate %.3fs",
                _fi,
                S.queueEstimate
            ))

        elseif (j.reader and impulse == nil)
            or os.clock() - j.requested
                > _aa.JumpQueueTimeout then

            _bb()

            _ag("JUMP NOT LAUNCHED", "No dive started")
            _ad("JUMP NOT LAUNCHED | request timed out or was canceled")
        end

        return true
    end

    if M.Controllers.IsLanded(character, humanoid) then
        _ba()
        S.jump = nil
    end

    return false
end

                                                                
                         
                                                                

local function _fk(f)
    if not _be(f) then return false end

    S.allowPositioning = false

    if S.ownedMove then
        local released = _ap(true)

        S.lastFrame = nil
        S.nextPlanAt = 0

        if released == "STOPPED" then
            S.holdStops = S.holdStops + 1

            _ag(
                "RECHECK HOLD",
                "Own movement stopped; waiting for a fresh update"
            )

            return false
        end
    end

    local fresh = _cc(f.character, f.root, f.humanoid)

    if not fresh
        or not finite(fresh.eta)
        or fresh.eta <= 0
        or fresh.flightKey ~= f.flightKey
        or fresh.root ~= f.root
        or fresh.context.goal ~= f.context.goal then

        S.lastFrame = nil
        S.nextPlanAt = 0

        _ag("REPLAN HOLD", "Ball, role, or goal state changed")
        return false
    end

    if not _be(fresh)
        or _bf(fresh.character, fresh.root) then
        return false
    end

    S.holdRechecks = S.holdRechecks + 1

    local horizon = math.min(
        _aa.PredictionHorizon,
        fresh.eta - _aa.GoalMarginSeconds
    )

    local hit

    if horizon > 0.0001 then
        hit = _da(
            fresh,
            { kind = "HOLD", delay = 0 },
            _cr(fresh, horizon),
            true
        )
    end

    if not hit then
        S.holdRecheckMisses = S.holdRecheckMisses + 1
        S.lastFrame = nil
        S.nextPlanAt = 0

        _ag(
            "REPLAN HOLD",
            "Current retained movement no longer predicts contact"
        )

        return false
    end

    _cb(fresh, { kind = "HOLD", contact = hit })
    fresh.plannerAnchor = os.clock()
    S.lastFrame = fresh
    S.nextPlanAt = math.min(S.nextPlanAt, _bv(fresh))

    _ag(
        "HOLD",
        string.format("Rechecked receive in %.3fs", hit.time)
    )

    return true
end

                                                                
                        
                                                                

local function _fl()
    return _bb()
end

local function _fm(ball)
    local jump = S.jump

    if not jump or jump.phase ~= "QUEUED" then
        return false
    end

    return not _aa.HighBallJumps
        or (jump.planned == "JUMP_DIVE" and not _aa.JumpThenDive)
        or not S.focused
        or S.uiBusy
        or UserInputService:GetFocusedTextBox() ~= nil
        or os.clock() < S.manualActionUntil
        or (ball ~= nil and (
            ball.phase ~= "MOVEMENT"
            or jump.flightKey ~= ball.flightKey
        ))
end

local function _fn(allowWrite)
    local failures = {}
    local function attempt(label, fn, ...)
        local ok, result = pcall(fn, ...)
        if not ok or result == false then
            failures[#failures + 1] = label .. ": " .. tostring(result)
            _ae(label, result)
        end
    end

    attempt("OWN POSITION RELEASE", _ar, allowWrite)

    if S.jump and S.jump.phase == "QUEUED" then
        attempt("OWN JUMP CANCEL", function()
            local j = S.jump
            if not j or j.phase ~= "QUEUED" then return true end

                                                                               
                                                                                  
                                                                               
            local impulse
            if j.reader then
                impulse = j.reader()
            else
                local root, character = j.root, j.character
                local humanoid = character
                    and character:FindFirstChildOfClass("Humanoid")
                impulse = root and root.Parent and humanoid
                    and finite(j.initialY)
                    and root.AssemblyLinearVelocity.Y > 1
                    and root.Position.Y > j.initialY + 0.035
                    and not M.Controllers.IsLanded(character, humanoid)
            end

            if S.jump ~= j then return true end
            if impulse then
                j.phase = "AIRBORNE"
                j.launched = os.clock()
                                                                                    
                return true
            end
            return _fl()
        end)
    end
    attempt("OWN JUMP RELEASE", _ba)

    if S.jump and S.jump.phase ~= "QUEUED" and not S.jump.latch then
        S.jump = nil
    end

    for lease in pairs(S.retiredMotions) do
        attempt("OWN MOTION RETRY", _at, lease)
    end
    for _, lease in pairs(S.retiredLocks) do
        attempt("OWN LOCK RETRY", _as, lease)
    end
    if S.motionLease then
        attempt("OWN MOTION RELEASE", _au, true)
    end

    if S.jumpBlockOwned then
        local ok, result = pcall(M.Movement.SetJumpStateBlocked,
            S.moveLock .. ".Queue", false)
        S.jumpBlockOwned = not (ok and result ~= false)
        if S.jumpBlockOwned then
            failures[#failures + 1] = "OWN JUMP BLOCK RELEASE: " .. tostring(result)
        end
    end

    S.currentContext = nil
    S.pending = nil
    S.lastFollowupBlock = nil
    S.wasKeeper = false

    if S.ownedMove or S.jump or S.jumpBlockOwned or S.motionLease
        or S.controller or next(S.retiredLocks) or next(S.retiredMotions) then
        failures[#failures + 1] = "Owned movement resources remain"
    end

    return #failures == 0, table.concat(failures, "; ")
end

S.releaseOwnedState = _fn

local function _fo()
    return S.wasKeeper
        or S.motionLease ~= nil
        or S.jump ~= nil
        or S.ownedMove ~= nil
        or S.jumpBlockOwned
        or next(S.retiredLocks) ~= nil
        or next(S.retiredMotions) ~= nil
end

_ac(UserInputService.InputBegan, function(_sl, processed)
    if not S.alive or processed or not S.wasKeeper then
        return
    end

    for _, name in ipairs({
        "Dive",
        "Tackle",
        "Dribble",
        "Jump",
        "RainbowFlick",
    }) do
        local ok, matched = pcall(
            M.Keybinds.Matches,
            name,
            _sl
        )

        if ok and matched then
            S.manualActionUntil = os.clock() + 0.30
            S.allowPositioning = false
            _ap(false)
            return
        end
    end
end)

                                                                
                            
                                                                

local function _fp(f, plan)
    if not _be(f) then return false end

    if plan.kind ~= "DIVE" or plan.delay ~= 0 then
        return false
    end

    if S.jump and not _aa.JumpThenDive then
        if S.lastFollowupBlock ~= S.jump then
            S.lastFollowupBlock = S.jump
            S.followupBlocks = S.followupBlocks + 1
        end

        _ag(
            "JUMP ONLY / RECOVERY",
            "Automatic follow-up dives are disabled"
        )

        return false
    end

    if os.clock() - f.readClock > 0.09 then
        _ag("REPLAN", "Planner sample expired")
        return false
    end

    if S.jump and (
        S.jump.phase ~= "AIRBORNE"
        or os.clock() - S.jump.launched
            < _aa.JumpDiveMinimumAge
    ) then
        return false
    end

    local reason = _bf(f.character, f.root)

    if reason or os.clock() < S.nextActionAt then
        return false
    end

    _ap(true)

    local fresh = _cc(f.character, f.root, f.humanoid)

    if fresh and not _bq(f.sourceTrajectory, fresh.sourceTrajectory) then
        S.lastFrame = nil
        S.nextPlanAt = 0
        _ag("REPLAN", "Trajectory changed before launch")
        return false
    end

    if not fresh
        or not fresh.eta
        or fresh.flightKey ~= f.flightKey
        or fresh.context.goal ~= f.context.goal
        or fresh.context.team ~= f.context.team then
        return false
    end

    local _fq = _ea(
        fresh,
        "DIVE",
        0,
        plan.name
    )

    if plan.useAssist then
        _fq.assist = _ed(fresh, _fq)
    end

    local horizon = math.min(
        M.Dive.Constants.HitboxCurveSeconds,
        fresh.eta - _aa.GoalMarginSeconds
    )

    if horizon <= 0.0001 then return false end

    local _fr = _cr(fresh, horizon)
    local hit = _da(fresh, _fq, _fr, true)

    if not hit and _fq.assist then
        _fq.assist = nil
        hit = _da(fresh, _fq, _fr, true)
    end

    if not hit then
        _ag(
            "REPLAN",
            "Final assisted motion has no contact"
        )

        return false
    end

    local exclusions = { fresh.character }
    local renderedBall = M.Renderer.GetBall()

    if renderedBall then
        table.insert(exclusions, renderedBall)
    end

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = exclusions
    params.RespectCanCollide = true

    local _fs = _cp(fresh, _fq, hit.time)
    local travel = _fs.Position - fresh.root.Position

    if travel.Magnitude > 0.05
        and workspace:Raycast(
            fresh.root.Position,
            travel,
            params
        ) then

        _ag("PATH BLOCKED", "No forced dive")
        return false
    end

    if not _be(fresh) or S.motionLease then
        return false
    end

    if S.jump and not _aa.JumpThenDive then
        return false
    end

    S.nextLeaseId = S.nextLeaseId + 1

    local lease = {
        id = S.nextLeaseId,
        character = fresh.character,
        root = fresh.root,

        lockName = S.moveLock
            .. "."
            .. tostring(S.nextLeaseId),

        lockHeld = false,
        controller = nil,
        closed = false,

        deadline = os.clock()
            + M.Dive.Constants.DurationSeconds
            + 2,
    }

    S.motionLease = lease

    local _ft
    local _fu
    local _fv = false
    local request

    S.nextActionAt =
        os.clock() + M.Dive.Constants.RepeatDelaySeconds

    local ok, err = pcall(function()
        lease.lockHeld = true

        M.Movement.LockMovement(lease.lockName)
        S.ownLockAcquires = S.ownLockAcquires + 1

        _ft = M.Dive.Run(
            fresh.root,
            fresh.humanoid,
            _fq.choice,

            function()
                return _fq.basis
            end,

            {
                Assist = _fq.assist,
                StartedAt = fresh.at,

                Finish = function(_, finished)
                    if S.motionLease == lease
                        and (
                            not lease.controller
                            or lease.controller == finished
                        ) then
                        _au(false, lease)
                    end
                end,
            }
        )

        assert(_ft, "Dive controller refused to start")

        assert(
            S.motionLease == lease and not lease.closed,
            "Dive completed before registration"
        )

        lease.controller = _ft
        S.controller = _ft

        assert(
            _be(fresh),
            "Action canceled before send"
        )

        local _fw = assert(
            M.Dive.GetMotionSample(fresh.root),
            "Missing motion sample"
        )

        local command = M.Actions.GoalkeeperDive({
            AimDirection = _fq.direction,
            DirectionName = _fq.name,
            DiveMotion = _fw,
            ShotTime = fresh.at,
        })

        request = {
            kind = "DIVE",
            command = command,
            at = os.clock(),
            ballId = fresh.ballId,
            flight = fresh.flightKey,
        }

        S.pending = request

        local _fx, result = pcall(M.Protocol.Send, command)

        if not _fx then
            _fv = true

            error(
                "Native action sender failed: " .. tostring(result),
                0
            )
        end

        if not finite(result) or command.ActionId ~= result then
            _fv = true

            error(
                "Native action sender returned an unexpected action ID",
                0
            )
        end

        _fu = result
        request.id = result

        _am("DIVE", fresh)

        if S.motionLease == lease and not lease.closed then
            local _fy, presentationError = pcall(
                M.Presentation.Play,
                fresh.character,
                _fq.name,
                fresh.at
            )

            if not _fy then
                _ae("PRESENTATION", _fz)
            end
        end
    end)

    S.nextActionAt = math.max(
        S.nextActionAt,

        os.clock() + (
            ok
                and M.Dive.Constants.RepeatDelaySeconds
                or 0.4
        )
    )

    if not ok then
        local _ga = lease.controller ~= nil

        _au(true, lease)

        if _ft and not _ga then
            pcall(_ft.Cancel)
        end

        if S.pending == request then
            S.pending = nil
        end

        if _fv then
            _s.AUTO_GK_ENABLED = false
            S.transportError = tostring(err)

            _fn(true)
            _ae("NATIVE SENDER", err)

            _ag(
                "OFF",
                "Native sender failed; automatic actions disabled"
            )
        else
            _ae("DIVE REQUEST", err)
            _ag("DIVE ERROR", tostring(err))
        end

        return false
    end

    _ba()
    S.jump = nil

    if S.pending == request then
        _ag(
            "DIVE SENT " .. _fq.name,

            string.format(
                "contact %.3fs / goal %.3fs",
                hit.time,
                fresh.eta
            )
        )
    end

    _ad(string.format(
        "DIVE SENT | %s | corrected contact %.3fs"
            .. " | goal %.3fs | margin %.3fs | id %.0f",
        _fq.name,
        hit.time,
        fresh.eta,
        fresh.eta - hit.time,
        _fu
    ))

    return true
end

                                                                
                  
                                                                

local function position(f, dt)
    if not S.allowPositioning or not _aa.PositionAssist then
        _ap(true)
        return
    end

    if S.jump or S.controller then
        _ap(false)
        return
    end

    if _aa.RespectManualMovement and _al() then
        S.manualUntil = os.clock() + _aa.ManualReleaseGrace
        _ap(false)
        return
    end

    if os.clock() < S.manualUntil then
        _ap(true)
        return
    end

    if os.clock() - f.readClock >= _aa.CachedFrameMaxAge then
        _ap(true)
        return
    end

    if _bf(f.character, f.root) then
        _ap(false)
        return
    end

    if not M.Controllers.IsLanded(f.character, f.humanoid) then
        _ap(false)
        return
    end

    local remaining = f.eta
        and f.eta - math.max(0, os.clock() - f.readClock)
        or nil

    local _gb =
        remaining ~= nil
        and remaining > 0
        and f.goalPosition ~= nil

    local coverage = f.isCoverage == true

    if coverage and not _aa.PreShotCoverage then
        _ap(true)
        return
    end

    if not coverage
        and not _gb
        and _aa.PositionMode == "THREATS" then
        _ap(true)
        return
    end

    if f.eta and not _gb then
        _ap(true)
        return
    end

    local c = f.context
    local origin = c.goal.Position
    local depth = _aa.HomeDepth
    local _gc = f.state.Position - origin

    local halfWidth = math.max(
        0.5,
        _bm(c) - 2
    )

    local lateral = _gc:Dot(c.right)
        * depth
        / math.max(depth, _gc:Dot(c.forward))

    if _gb then
        local crossing =
            (f.goalPosition - origin):Dot(c.right)

        local current =
            (f.root.Position - origin):Dot(c.right)

        lateral = math.clamp(
            current,
            crossing - _aa.SafeLateralReach,
            crossing + _aa.SafeLateralReach
        )

        if f.state.Position.Y - f.root.Position.Y > 5 then
            depth = math.max(3.5, depth - 2.5)
        end
    end

    lateral = math.clamp(lateral, -halfWidth, halfWidth)

    local _gd = coverage
        and f.coverageTarget
        or origin + c.forward * depth + c.right * lateral

    local key = (coverage and "COVER:" or "SHOT:")
        .. tostring(c.goal)
        .. ":"
        .. f.flightKey
        .. ":"
        .. _aa.PositionMode

    if S.positionKey ~= key then
        _an()
        S.positionKey = key
        S.positionTarget = _gd

    elseif flat(_gd - S.positionTarget).Magnitude
        > _aa.TargetChangeDeadzone then

        local _ge = math.max(
            0.01,
            _aa.TargetResponseSeconds
        )

        local alpha = _gb and remaining < 0.35
            and 1
            or 1 - math.exp(
                -math.clamp(dt, 0, 0.10) / _ge
            )

        S.positionTarget = S.positionTarget:Lerp(
            _gd,
            alpha
        )
    end

    local _gf = flat(
        S.positionTarget - f.root.Position
    )

    local _gg = coverage
        and _aa.CoverageStartRadius
        or (
            _gb
                and _aa.PositionStartDeadzone
                or _aa.HomeRadius
        )

    local _gh = coverage
        and _aa.CoverageStopRadius
        or (
            _gb
                and _aa.PositionDeadzone
                or _aa.HomeStopRadius
        )

    _gg = math.max(_gg, _gh + 0.05)

    local distance = _gf.Magnitude
                                                                           
                                                                          
    local _gi = coverage
        and (_gh + math.min(0.15, (_gg - _gh) * 0.5))
        or _gh

    if S.positionActive then
        if distance <= _gi then
            _ap(true)
            return
        end
    elseif distance < _gg then
        if S.ownedMove then
            _ap(true)
        end
        return
    else
        S.positionActive = true
        S.positionChangedAt = os.clock()
    end

    local _gj = _gf:Dot(c.forward)
    local _gk = _gf:Dot(c.right)
    local vector = _gf

    if not coverage and (not _gb or remaining > 1.3) then
        if math.abs(_gj) > 1.4 then
            vector = c.forward * _gj
                + c.right * _gk * 0.2
        elseif math.abs(_gk) > _gh then
            vector = c.right * _gk
        else
            vector = c.forward * _gj
        end
    elseif not coverage and remaining > 0.65 then
        vector = c.forward * _gj * 0.6
            + c.right * _gk
    end

    if vector.Magnitude < 0.05 then
        _ap(true)
        return
    end

    local scale = math.clamp(
        (distance - _gh) / 3,
        0,
        1
    )

    local _gl = vector.Unit * scale

    if S.ownedMove then
        local old = S.ownedMove

        if old.Magnitude > 0.001 and old:Dot(_gl) < 0 then
            old = Vector3.zero
        end

        _gl = old:Lerp(
            _gl,

            1 - math.exp(
                -math.clamp(dt, 0, 0.10)
                    / math.max(
                        0.01,
                        _aa.PositionResponseSeconds
                    )
            )
        )
    end

    if _gl.Magnitude < 0.005 then
        _ap(true)
        return
    end

    if coverage then
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = { f.character }
        params.RespectCanCollide = true

        local probe = _gl.Unit * math.min(distance, 3)

        local shoulder = c.right
            * math.max(0.5, f.root.Size.X * 0.4)

        for _, _ns in ipairs({
            Vector3.zero,
            shoulder,
            -shoulder,
        }) do
            if workspace:Raycast(
                f.root.Position + _ns,
                probe,
                params
            ) then
                _ap(true)
                S.allowPositioning = false

                _ag(
                    "COVERAGE BLOCKED",
                    "Walking path is obstructed"
                )

                return
            end
        end

        S.coverageWrites = S.coverageWrites + 1
    end

    M.Controllers.SetMoveCommand(f.character, _gl)

    S.ownedMove = _gl
    S.moveCharacter = f.character
    S.positionWrites = S.positionWrites + 1
end

                                                                
               
                                                                

local function _gm()
    local pending = S.pending

    if not pending then
        return nil
    end

    return pending.id
        or (pending.command and pending.command.ActionId)
end

_ac(_y.OnClientEvent, function(payload)
    if not S.alive or typeof(payload) ~= "table" then
        return
    end

    local key = tostring(payload.BallId)

    if payload.Kind == "Movement" or payload.Kind == "Removed" then
        S.catches[key] = nil

        if payload.BallId == M.Renderer.GetMatchBallId() then
            S.nextPlanAt = 0
        end

        return
    end

    if payload.Kind ~= "Owned"
        or payload.OwnerUserId ~= _p.UserId then
        return
    end

    if not (
        payload.IsDiveCatch
        or payload.IsGoalkeeperJumpCatch
    ) then
        return
    end

    if S.catches[key] == payload.OwnerUserId then
        return
    end

    S.catches[key] = payload.OwnerUserId
    _ab.CatchesObserved = _ab.CatchesObserved + 1

    local expectedId = _gm()

    local matched =
        expectedId ~= nil
        and payload.ActionId == expectedId
        and S.pending ~= nil
        and payload.BallId == S.pending.ballId

    if matched then
        _ab.ActionMatches = _ab.ActionMatches + 1
    end

    _ad(string.format(
        "CATCH OBSERVED | %s | action-match %s",
        payload.IsDiveCatch and "dive" or "jump",
        tostring(matched == true)
    ))

    _ag(
        "CATCH OBSERVED",
        matched
            and "Matching action ID"
            or "No action attribution supplied"
    )

    if S.pending and payload.BallId == S.pending.ballId then
        S.pending = nil
    end
end)

_ac(_x.OnClientEvent, function(packet)
    if not S.alive
        or typeof(packet) ~= "table"
        or typeof(packet.Command) ~= "table" then
        return
    end

    if packet.Protocol ~= "ActionCommand"
        or packet.Phase ~= "ExecuteRejected" then
        return
    end

    local expectedId = _gm()

    if expectedId == nil
        or packet.Command.ActionId ~= expectedId then

        _ae(
            "UNMATCHED ACTION REJECTION",

            string.format(
                "mode %s | id %s | cooldown %s",
                tostring(packet.Command.Mode),
                tostring(packet.Command.ActionId),
                tostring(packet.CooldownRemainingSeconds)
            )
        )

        return
    end

    _ab.Rejected = _ab.Rejected + 1

    local _gn = math.max(
        0.25,
        tonumber(packet.CooldownRemainingSeconds) or 0.25
    )

    if finite(packet.CooldownEndsAt) then
        _gn = math.max(
            _gn,
            packet.CooldownEndsAt - workspace:GetServerTimeNow()
        )
    end

    S.nextActionAt = math.max(
        S.nextActionAt,
        os.clock() + _gn
    )

    local _go = S.controller ~= nil

    _au(true)

    if _go and _p.Character then
        M.Presentation.Stop(_p.Character)
    end

    S.pending = nil

    _ag(
        "SERVER REJECTED",
        string.format("Wait %.2fs", _gn)
    )

    _ad(
        "SERVER REJECTED | "
            .. tostring(packet.Command.ActionId)
    )
end)

                                                                
                   
                                                                

_aa.CloseRangeRush = true
_ab.RushRequests = 0

local _gp = {
    Role = M.Role,
    Actors = M.Actors,
    Motion = M.Motion,

    Range = 12,
    GoalDepth = 28,
    ContactHorizon = 0.30,
    ScanInterval = 0.05,
    ConfirmSeconds = 0.05,

    nextScan = 0,
    candidate = nil,
    candidateSince = 0,
    lastSeenAt = 0,
}

local function _gq(v)
    return _aj(v)
end

local function _gr(character, root, humanoid)
    if not _aa.CloseRangeRush
        or S.jump
        or S.motionLease
        or S.controller then
        return nil
    end

    if not _be({
        character = character,
        humanoid = humanoid,
    }) then
        return nil
    end

    if _al()
        or _ay()
        or os.clock() < S.manualUntil then
        return nil
    end

    if os.clock() < S.nextActionAt
        or _bf(character, root) then
        return nil
    end

    if not _gp.Role.IsGoalkeeper()
        or not M.Controllers.IsLanded(character, humanoid) then
        return nil
    end

    local ball = _bn()

    if ball.phase ~= "OWNED"
        or not finite(ball.owner)
        or ball.owner == _p.UserId then
        return nil
    end

    local actor = _gp.Actors.GetByUserId(ball.owner)
    local target = actor and _gp.Actors.GetCharacter(actor)

    local _gs =
        target and target:FindFirstChild("HumanoidRootPart")

    local targetHumanoid =
        target and target:FindFirstChildOfClass("Humanoid")

    if not _gs
        or not targetHumanoid
        or targetHumanoid.Health <= 0 then
        return nil
    end

    local ownTeam = M.Teams.GetActorTeamName(_p)
    local otherTeam = M.Teams.GetActorTeamName(actor)

    if ownTeam == nil
        or otherTeam == nil
        or ownTeam == otherTeam then
        return nil
    end

    if M.Match.IsGoalkeeperCharacter(target)
        or not M.Controllers.IsLanded(target, targetHumanoid) then
        return nil
    end

    local context = _bh(root)
    if not context then return nil end

    local _gt = _gp.Motion.GetPosition(target)
    local velocity = _gp.Motion.GetVelocity(target)
    local ballPosition = M.Renderer.GetPosition()

    if not _gq(_gt)
        or not _gq(velocity)
        or not _gq(ballPosition) then
        return nil
    end

    if (ballPosition - _gt).Magnitude > 7 then
        return nil
    end

    if math.abs(velocity.Y) > 6 then return nil end

    velocity = flat(velocity)

    local offset = flat(_gt - root.Position)
    local distance = offset.Magnitude

    if distance < 0.25 or distance > _gp.Range then
        return nil
    end

    local _gu = context.goal.Position

    local _gv =
        (root.Position - _gu):Dot(context.forward)

    local _gw =
        (_gt - _gu):Dot(context.forward)

    local halfWidth = _bm(context)

    if _gv < 0 or _gv > _gp.GoalDepth then
        return nil
    end

    if _gw < _gv - 1
        or _gw > _gp.GoalDepth
        or _gw < 0 then
        return nil
    end

    if math.abs(
        (_gt - _gu):Dot(context.right)
    ) > halfWidth + 2 then
        return nil
    end

    if velocity:Dot(context.forward) > 2 then
        return nil
    end

    local _gx = -velocity:Dot(offset.Unit)
    local _gy = _ak(_gu - _gt)

    local _gz =
        _ak(_gs.CFrame.LookVector):Dot(_gy)
            > 0.40

    if distance > 6 and _gx < 1 and not _gz then
        return nil
    end

    local floorY = M.Grounding.GetStandingY(humanoid, root)
    if not finite(floorY) then return nil end

    local camera = workspace.CurrentCamera
    local cameraCF = camera and camera.CFrame or root.CFrame

    return {
        character = character,
        root = root,
        humanoid = humanoid,
        rootCF = root.CFrame,
        floorY = floorY,
        context = context,
        target = target,
        owner = ball.owner,
        ballId = ball.ballId,
        ballPosition = ballPosition,
        targetPosition = _gt,
        targetVelocity = velocity,
        cameraCF = cameraCF,
        readClock = os.clock(),
        halfWidth = halfWidth,
    }
end

local function _ha(direction, context)
    local forward = direction:Dot(context.forward)
    local right = direction:Dot(context.right)

    if forward < -0.20 then return false end

    local filter = _aa.DiveFilter

    if filter == "FORWARD" then
        return forward > 0.90
    end

    if filter == "LEFT" then
        return right < -0.35
    end

    if filter == "RIGHT" then
        return right > 0.35
    end

    if filter == "SIDES" then
        return math.abs(right) > 0.35
    end

    return true
end

local function _hb(f, plan)
    local horizon = math.min(
        _gp.ContactHorizon,
        M.Dive.Constants.HitboxCurveSeconds
    )

    local box = M.Hitboxes.AirReceive

    local previousTime = 0
    local _hc = f.ballPosition
    local previousRoot = f.rootCF
    local time = 0

    while time < horizon - 0.000001 do
        time = math.min(horizon, time + 0.01)

        local ballPosition =
            f.ballPosition + f.targetVelocity * time

        local rootCF = _cp(f, plan, time)

        local hit = M.Contacts.FindDiveSaveContact(
            _p,
            _hc,
            ballPosition,
            {
                StartRootCFrame = previousRoot,
                EndRootCFrame = rootCF,
                BallRadius = M.Physics.BallRadius,
            }
        )

        local _hd = M.Hitboxes.GetSegmentEnterAlpha(
            { CFrame = rootCF },
            box,
            _hc + rootCF.Position - previousRoot.Position,
            ballPosition
        )

        if hit and _hd then
            local contactTime = previousTime
                + (time - previousTime)
                * math.max(hit.Alpha, _hd)

            if contactTime >= 0.03 then
                return contactTime
            end
        end

        previousTime = time
        _hc = ballPosition
        previousRoot = rootCF
    end

    return nil
end

local function _he(f, plan)
    local exclusions = { f.character, f.target }
    local renderedBall = M.Renderer.GetBall()

    if renderedBall then
        exclusions[#exclusions + 1] = renderedBall
    end

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = exclusions
    params.RespectCanCollide = true

    local side = Vector3.new(
        -plan.direction.Z,
        0,
        plan.direction.X
    )

    local shoulder =
        side * math.max(0.5, f.root.Size.X * 0.4)

    local origin = f.context.goal.Position
    local previous = f.root.Position
    local duration = M.Dive.Constants.DurationSeconds
    local time = 0

    while time < duration - 0.000001 do
        time = math.min(duration, time + 0.05)

        local position = _cp(f, plan, time).Position
        local offset = position - origin
        local depth = offset:Dot(f.context.forward)

        if depth < -0.5 or depth > _gp.GoalDepth then
            return false
        end

        if math.abs(offset:Dot(f.context.right))
            > f.halfWidth + 2 then
            return false
        end

        local travel = position - previous

        if travel.Magnitude > 0.001 then
            for _, _ns in ipairs({
                Vector3.zero,
                shoulder,
                -shoulder,
            }) do
                if workspace:Raycast(
                    previous + _ns,
                    travel,
                    params
                ) then
                    return false
                end
            end
        end

        previous = position
    end

    return true
end

local function _hf(f)
    local best

    local toward = _ak(
        f.targetPosition - f.root.Position,
        f.context.forward
    )

    for _, name in ipairs({
        "F", "LF", "L", "LB",
        "RF", "R", "RB", "B",
    }) do
        local choice = M.Dive.GetDirectionChoiceByName(name)

        local direction = M.Dive.GetWorldDirection(
            choice,
            f.cameraCF,
            _ak(f.rootCF.LookVector)
        )

        if _ha(direction, f.context)
            and direction:Dot(toward) > 0.50 then

            local plan = {
                kind = "DIVE",
                name = name,
                choice = choice,
                direction = direction,
                origin = f.rootCF,
                delay = 0,
                assist = nil,
            }

            local contact = _hb(f, plan)

            if contact then
                plan.contact = contact

                plan.score = contact
                    + 0.08 * (1 - direction:Dot(toward))

                if (not best or plan.score < best.score)
                    and _he(f, plan) then
                    best = plan
                end
            end
        end
    end

    return best
end

local function _hg(character, root, humanoid)
    if os.clock() < _gp.nextScan then return false end

    _gp.nextScan = os.clock() + _gp.ScanInterval

    if os.clock() - _gp.lastSeenAt > 0.15 then
        _gp.candidate = nil
    end

    local f = _gr(character, root, humanoid)

    if not f then
        _gp.candidate = nil
        return false
    end

    _gp.lastSeenAt = os.clock()

    local key =
        tostring(f.ballId) .. ":" .. tostring(f.owner)

    if _gp.candidate ~= key then
        _gp.candidate = key
        _gp.candidateSince = os.clock()
        return false
    end

    if os.clock() - _gp.candidateSince
        < _gp.ConfirmSeconds then
        return false
    end

    local plan = _hf(f)

    if not plan or os.clock() - f.readClock > 0.05 then
        return false
    end

    local current = _bn()

    if current.phase ~= "OWNED"
        or current.owner ~= f.owner
        or current.ballId ~= f.ballId then
        return false
    end

    if _p.Character ~= character
        or not _aa.CloseRangeRush then
        return false
    end

    if not _be(f)
        or _bf(character, root)
        or _al() then
        return false
    end

    if _gp.Actors.GetCharacter(
        _gp.Actors.GetByUserId(f.owner)
    ) ~= f.target then
        return false
    end

    local camera = workspace.CurrentCamera
    local cameraCF = camera and camera.CFrame or root.CFrame

    if _ak(cameraCF.LookVector):Dot(
        _ak(f.cameraCF.LookVector)
    ) < 0.999 then
        return false
    end

    local _hh = M.Dive.GetDirectionChoice(
        plan.direction,
        cameraCF,
        _ak(root.CFrame.LookVector)
    )

    if _hh.Name ~= plan.choice.Name then
        return false
    end

    if S.ownedMove then
        _ap(true)
    end

    local _hi =
        M.Controllers.GetMoveCommand(character)

    if not _gq(_hi) then
        return false
    end

    local _hj = false

    local ok, started = pcall(function()
        _hj = true

        M.Controllers.SetMoveCommand(
            character,
            plan.direction
        )

        local selected = M.Dive.GetDirectionChoice(
            M.Controllers.GetMoveCommand(character),
            cameraCF,
            _ak(root.CFrame.LookVector)
        )

        if selected.Name ~= plan.choice.Name then
            return false
        end

        local _hk = _bn()

        if _hk.phase ~= "OWNED"
            or _hk.owner ~= f.owner
            or _hk.ballId ~= f.ballId
            or not _aa.CloseRangeRush then
            return false
        end

        return _gp.Role.Dive()
    end)

    local _hl, restoreError = pcall(function()
        if not _hj
            or _p.Character ~= character
            or not character.Parent then
            return
        end

        local _hn = M.Controllers.GetMoveCommand(character)

        if not _gq(_hn) then
            error("Cannot read movement after rush")
        end

        if _hn.Magnitude > 0.01
            and _hn.Unit:Dot(plan.direction) > 0.999 then

            M.Controllers.SetMoveCommand(
                character,
                _hi
            )
        end
    end)

    _gp.candidate = nil

    if not _hl then
        _s.AUTO_GK_ENABLED = false
        _ae("CLOSE RUSH MOVEMENT", _hm)
    end

    if not ok then
        _aa.CloseRangeRush = false

        local cleaned, cleanupError =
            pcall(_gp.Role.Cleanup)

        if not cleaned then
            _ae("CLOSE RUSH CLEANUP", _ho)
        end

        _ae("CLOSE RUSH", started)

        _ag(
            "RUSH DISABLED",
            "Native dive failed; shot saves unchanged"
        )

        return false
    end

    if started ~= true then return false end

    S.nextActionAt = math.max(
        S.nextActionAt,
        os.clock() + M.Dive.Constants.RepeatDelaySeconds
    )

    S.nextPlanAt = 0
    S.allowPositioning = false

    S.pending = {
        kind = "RUSH",
        at = os.clock(),
        ballId = f.ballId,
    }

    _am("DIVE", nil)
    _ab.RushRequests = _ab.RushRequests + 1

    _ag(
        "CLOSE-RANGE RUSH",
        "Native dive; interception predicted, outcome not confirmed"
    )

    _ad(string.format(
        "CLOSE-RANGE RUSH | %s | modeled contact %.3fs",
        plan.name,
        plan.contact
    ))

    return true
end

                                                                
                          
                                                                

local function _hp(context, ballPosition, ballVelocity)
    local lead = flat(ballVelocity) * _aa.CoverageLeadSeconds

    if lead.Magnitude > _aa.CoverageMaximumLead then
        lead = lead.Unit * _aa.CoverageMaximumLead
    end

    local offset =
        ballPosition + lead - context.goal.Position

    local x = offset:Dot(context.right)
    local z = offset:Dot(context.forward)
    local width = _bm(context)

    if z <= 2
        or z > _aa.CoverageRange
        or math.abs(x) > width + 22 then
        return nil
    end

    local depth = math.min(
        math.clamp(
            z * 0.30,
            _aa.CoverageMinimumDepth,

            math.max(
                _aa.CoverageMinimumDepth,
                _aa.HomeDepth
            )
        ),

        z - 1.25
    )

    local left = Vector3.new(-width - x, 0, -z)
    local right = Vector3.new(width - x, 0, -z)
    local _hq = left.Unit + right.Unit

    if math.abs(_hq.Z) < 0.0001 then
        return nil
    end

    local lateral =
        x + (depth - z) * _hq.X / _hq.Z

    local _hr = math.max(0.5, width - 1.5)

    lateral = math.clamp(lateral, -_hr, _hr)

    return context.goal.Position
        + context.forward * depth
        + context.right * lateral
end

local function _hs(
    character,
    root,
    humanoid,
    ball,
    context
)
    if ball.phase ~= "OWNED"
        or not finite(ball.owner)
        or ball.owner == _p.UserId then
        return nil
    end

    local actor = _gp.Actors.GetByUserId(ball.owner)
    local target = actor and _gp.Actors.GetCharacter(actor)

    local targetHumanoid =
        target and target:FindFirstChildOfClass("Humanoid")

    if not targetHumanoid or targetHumanoid.Health <= 0 then
        return nil
    end

    local ownTeam = M.Teams.GetActorTeamName(_p)
    local otherTeam = M.Teams.GetActorTeamName(actor)

    if ownTeam == nil
        or otherTeam == nil
        or ownTeam == otherTeam then
        return nil
    end

    if M.Match.IsGoalkeeperCharacter(target) then
        return nil
    end

    local ballPosition = M.Renderer.GetPosition()
    local _ht = _gp.Motion.GetPosition(target)
    local velocity = _gp.Motion.GetVelocity(target)

    if not _gq(ballPosition)
        or not _gq(_ht)
        or not _gq(velocity) then
        return nil
    end

    if (ballPosition - _ht).Magnitude > 7 then
        return nil
    end

    local _hu = root.Position - context.goal.Position
    local depth = _hu:Dot(context.forward)

    if depth < -1
        or depth > _gp.GoalDepth
        or math.abs(_hu:Dot(context.right))
            > _bm(context) + 2 then
        return nil
    end

    local _hv = _hp(
        context,
        ballPosition,
        velocity
    )

    if not _hv then
        return nil
    end

    return {
        isCoverage = true,
        character = character,
        root = root,
        humanoid = humanoid,
        context = context,
        target = target,
        targetHumanoid = targetHumanoid,
        owner = ball.owner,
        ballId = ball.ballId,
        coverageTarget = _hv,
        state = { Position = ballPosition },
        flightKey = "OWNER:" .. tostring(ball.owner),
        readClock = os.clock(),
        goalFrame = context.goal.CFrame,
    }
end

local function _hw(
    character,
    root,
    humanoid,
    ball,
    context,
    dt
)
    if not _aa.PreShotCoverage
        or not _aa.PositionAssist
        or S.jump
        or S.controller
        or not M.Controllers.IsLanded(character, humanoid) then

        S.coverageFrame = nil
        S.allowPositioning = false
        _ap(true)
        return false
    end

    if _aa.RespectManualMovement and _al() then
        S.manualUntil = os.clock() + _aa.ManualReleaseGrace
        S.coverageFrame = nil
        S.allowPositioning = false
        _ap(false)
        return false
    end

    local frame = S.coverageFrame
    local clock = os.clock()

    if not frame
        or clock >= S.coverageNextAt
        or frame.owner ~= ball.owner
        or frame.root ~= root
        or frame.context.goal ~= context.goal
        or frame.goalFrame ~= context.goal.CFrame then

        frame = _hs(
            character,
            root,
            humanoid,
            ball,
            context
        )

        S.coverageFrame = frame

        S.coverageNextAt =
            clock + 1 / _aa.CoverageUpdateHz
    end

    if not frame
        or clock - frame.readClock > _aa.CachedFrameMaxAge
        or not frame.target.Parent
        or frame.targetHumanoid.Health <= 0 then

        S.allowPositioning = false
        _ap(true)
        return false
    end

    local current = _bn()

    if current.phase ~= "OWNED"
        or current.owner ~= frame.owner
        or current.ballId ~= frame.ballId then

        _ar(true)
        return false
    end

    S.allowPositioning = true
    position(frame, dt)

    if S.allowPositioning then
        _ag(
            "COVERING ANGLE",
            S.positionActive
                and "Adjusting before the shot"
                or "Holding the covered angle"
        )
    end

    return true
end

                                                                
            
                                                                

local function tick(dt)
    if not S.alive then return end

    _ax()

    if not _s.AUTO_GK_ENABLED or not _aa.Enabled then
        if _fo() then
            _fn(true)
        end

        _ag("OFF", S.runtimeError
            and "Repeated runtime error; inspect AutoGKDebug() before retrying"
            or nil)
        return
    end

    local character = _p.Character

    local humanoid =
        character and character:FindFirstChildOfClass("Humanoid")

    local root =
        character and character:FindFirstChild("HumanoidRootPart")

    if not root or not humanoid or humanoid.Health <= 0 then
        if _fo() then
            _fn(false)
        end

        _ag("NO CHARACTER")
        return
    end

    if character ~= S.lastChar then
        if _fo() then
            _fn(false)
        else
            _ar(false)
        end

        S.jump = nil
        S.pending = nil
        S.lastChar = character
        S.ballSignature = nil
        S.currentContext = nil
        S.missingSince = nil
    end

    if not M.Match.IsGoalkeeperCharacter(character) then
        if _fo() then
            _fn(true)
        end

        _ag("WAITING FOR GK", "Manual controls untouched")
        return
    end

    S.wasKeeper = true

                                                                                 
    local _hx = _fh(character, root, humanoid)

    if _fm(nil) then
        _fl()
    end

    if not S.focused then
        _ar(true)
        _fl()
        _ag("WINDOW UNFOCUSED")
        return
    end

    if S.uiBusy or os.clock() < S.manualActionUntil then
        _ar(false)

        _ag(
            S.uiBusy and "INTERFACE OPEN" or "MANUAL ACTION",
            "Automatic requests paused"
        )

        return
    end

    local ball = _bn()
    S.ballPhase = ball.phase

    local _hy = tostring(ball.ballId)
        .. ":"
        .. ball.phase
        .. ":"
        .. tostring(ball.flightKey or ball.owner)

    if _hy ~= S.ballSignature then
        _ar(true)
        S.ballSignature = _hy
        S.observedBallId = ball.ballId
    end

    local context = _bh(root, ball.state)

    if not context then
        _ar(true)
        _fl()
        S.currentContext = nil
        _ag("WAITING FOR TEAM / GOAL")
        return
    end

    if S.currentContext and (
        S.currentContext.goal ~= context.goal
        or S.currentContext.team ~= context.team
    ) then
        _ar(true)
        _fl()
    end

    S.currentContext = context

    if _fm(ball) then
        _fl()
    end

    if _hx and S.jump then
        S.allowPositioning = false

        if S.jump and S.jump.phase == "QUEUED" then
            _ag("JUMP QUEUED", "Waiting for takeoff")
        end

        return
    end

    if S.controller then
        S.allowPositioning = false
        _ap(false)
        return
    end

    local _hz = _bf(character, root)

    if _hz then
        _ar(false)
        _ag(_hz)
        return
    end

    if UserInputService:GetFocusedTextBox() then
        _ar(true)
        _ag("TEXT INPUT")
        return
    end

    if ball.phase ~= "MOVEMENT" then
        S.lastFrame = nil

        if ball.phase == "OWNED" then
            S.ballInfo = ball.owner == _p.UserId
                and "Held by you"
                or "Held by another actor"

            S.missingSince = nil

            local _ia, rushed = pcall(
                _hg,
                character,
                root,
                humanoid
            )

            if not _ia then
                _aa.CloseRangeRush = false
                _gp.candidate = nil
                _ae("CLOSE RUSH DISABLED", _ib)

            elseif _ib then
                S.coverageFrame = nil
                return
            end

            local _ic, covered = pcall(
                _hw,
                character,
                root,
                humanoid,
                ball,
                context,
                dt
            )

            if not _ic then
                _aa.PreShotCoverage = false
                _ar(true)

                _ae(
                    "PRE-SHOT COVERAGE DISABLED",
                    _id
                )

            elseif _id then
                return
            end
        else
            _gp.candidate = nil
            _ar(true)
        end

        S.allowPositioning = false
        _ap(true)
        _bo(ball, context)
        return
    end

    _gp.candidate = nil
    S.missingSince = nil
    S.ballInfo = "Movement trajectory available"

    if S.lastFrame and (
        S.lastFrame.flightKey ~= ball.flightKey
        or S.lastFrame.world ~= ball.world
        or S.lastFrame.root ~= root
    ) then
        _ar(true)
    end

    if S.lastFrame and _br(S.lastFrame, ball) then
                                                                             
                                                                              
        S.nextPlanAt = 0
    end

    if os.clock() < S.nextPlanAt then
        if S.allowPositioning and S.lastFrame then
            position(S.lastFrame, dt)
        end

        return
    end

    local f, reason, unavailable = _cc(
        character,
        root,
        humanoid
    )

    S.lastFrame = f

    if not f then
        _ar(true)

        if _ie then
            _bo(_ie, context)
        else
            _ag(reason or "NO STATE")
        end

        return
    end

    S.currentContext = f.context

    f.plannerAnchor = os.clock()
    S.nextPlanAt = _bv(f)

    if not f.eta or f.eta <= 0 then
        S.allowPositioning = _aa.PositionMode ~= "THREATS"

        position(f, dt)

        _ag(
            "READY / " .. f.context.mode,

            S.allowPositioning
                and "No goal-bound shot; home positioning enabled"
                or "No goal-bound shot; idle movement off"
        )

        return
    end

    if f.eta > _aa.PredictionHorizon then
        S.allowPositioning = true
        position(f, dt)

        _ag(
            "TRACKING",
            string.format("Goal in %.2fs", f.eta)
        )

        return
    end

    S.allowPositioning = false

    local plan, noPlan = _er(f)
    _cb(f, plan)
    S.nextPlanAt = _bv(f)

    if plan and plan.kind == "HOLD" then
        _fk(f)
        return
    end

    if not plan then
        S.allowPositioning = true
        position(f, dt)

        _ag(
            _if or "NO VERIFIED CONTACT",
            "No blind emergency dive"
        )

        return
    end

    if os.clock() < S.nextActionAt then
        S.allowPositioning = true
        position(f, dt)
        _ag("ACTION COOLDOWN")
        return
    end

    if plan.kind == "JUMP" or plan.kind == "JUMP_DIVE" then
        _fc(f, plan)

    elseif plan.delay > 0 then
                                                                                 
                                                                           
        S.nextPlanAt = math.min(S.nextPlanAt, f.readClock + plan.delay)
        S.allowPositioning = true
        position(f, dt)

        _ag(
            "TIMING DIVE " .. plan.name,

            string.format(
                "Replan in %.2fs",
                math.max(0, S.nextPlanAt - os.clock())
            )
        )
    else
        _fp(f, plan)
    end
end

_ac(RunService.Heartbeat, function(dt)
    if not S.alive or S.loopBusy
        or os.clock() < S.runtimeRetryAt then return end

    S.loopBusy = true

    local ok, err = xpcall(function()
        tick(dt)
    end, debug.traceback)

    S.loopBusy = false

    if not ok then
        S.runtimeFailures = S.runtimeFailures + 1
        S.runtimeError = tostring(err)
        S.runtimeRetryAt = os.clock() + _aa.RuntimeErrorRetrySeconds
        pcall(_fn, true)

        if S.runtimeFailures >= _aa.RuntimeErrorLimit then
            _s.AUTO_GK_ENABLED = false
        end

        _ag(
            _s.AUTO_GK_ENABLED and "RUNTIME ERROR" or "OFF",
            S.runtimeError:match("[^\n]+")
        )

        _ae("RUNTIME", err)
    elseif _s.AUTO_GK_ENABLED and _aa.Enabled then
        S.runtimeFailures = 0
        S.runtimeRetryAt = 0
        S.runtimeError = nil
    end
end)

                                                                              
local function _ig(d)
    local A = { Enabled = false, AutoCurve = false, SmartRelease = false, Ready = false, Status = "OFF", Detail = "", LastError = nil }
    local C = { SliceMs = 2.5, CallsPerSlice = 4, Horizon = 2.2, Step = 0.035,
        SampleHz = 30, CandidateAge = 0.35, NetworkMargin = 0.10, EdgeMargin = 0.65, TargetSlack = 0.35,
        MaxAssistDistance = 55, ClearGapThreshold = 0.75, VolleyPrepareSeconds = 0.30,
        ReleaseInterval = 0.05, ReleaseMargin = 0.35, ReleaseBudgetMs = 2.5 }
    local stats = { shots = 0, assisted = 0, redirected = 0, confirmed = 0, rejected = 0, candidates = 0, evaluations = 0,
        errors = 0, maxSliceMs = 0, maxAimMs = 0, lastCharge = 0, lastCurve = 0,
        releaseChecks = 0, releaseBudgetSkips = 0, releaseRequests = 0, autoReleases = 0, maxReleaseMs = 0 }
    local _ih = {}
                                                                     
    local N: { [string]: any } = {}
    local _ii, hooks = nil, {}
    local _ij = nil
    local _ik = setmetatable({}, { __mode = "k" })
    local _il = setmetatable({}, { __mode = "k" })
    local mainThread = {}
    local alive, _im, installing = true, false, false
    local _io, UP = Vector3.zero, Vector3.new(0, 1, 0)
    local function _iq(n) return type(n) == "number" and n == n and math.abs(n) < math.huge end
    local function _ir(v) return typeof(v) == "Vector3" and _iq(v.X) and _iq(v.Y) and _iq(v.Z) end
    local function flat(v) return Vector3.new(v.X, 0, v.Z) end
    local function _is() return coroutine.running() or mainThread end
    local function _it(name, detail) A.Status, A.Detail = name, detail or "" end
    local function _iu(err)
        stats.errors += 1
        A.LastError = tostring(err)
        local pair = _ii and _ii.pair
        if pair and math.abs(pair.curve - pair.manualCurve) > 1e-5 and N.Client then
            local ok, cancelError = pcall(function()
                if N.Client.IsCharging() then N.Client.CancelCharge() end
            end)
            if not ok then A.LastError ..= " | Curve charge cancellation: " .. tostring(_iv) end
        end
        A.Enabled = false
        _ii = nil
        table.clear(_il)
        _it("STR ERROR", "Normal shooting remains available; run AutoSTRDebug().")
        warn("[Auto STR] " .. A.LastError)
    end
    local function _iw(fn, ...)
        local result = table.pack(pcall(fn, ...))
        if not result[1] then _iu(result[2]); return nil end
        return table.unpack(result, 2, result.n)
    end
    local function _ix(fn, ...)
        if not alive or not A.Enabled then return fn(...) end
        local key = _is()
        local previous = _ik[key]
        _ik[key] = { applied = false }
        local result = table.pack(pcall(fn, ...))
        _ik[key] = previous
                                                                             
        if not result[1] then error(result[2], 0) end
        return table.unpack(result, 2, result.n)
    end
    local function ballId()
        return type(d.M.Renderer.GetMatchBallId) == "function" and d.M.Renderer.GetMatchBallId() or nil
    end
    local function ownsBall()
        local ch = d.Player.Character
                                                                                    
                                                                                     
        if _ij and _ij.character == ch and _ij.ballId == ballId()
            and _ij.context == d.M.Motion.GetContext(ch) then
            return _ij.userId == d.Player.UserId
        end
        return d.M.Renderer.GetOwnedUserId() == d.Player.UserId
    end
    local _iy = {
        suspended = "Input or UI is busy", no_character = "Waiting for a live character",
        goalkeeper = "GK role is active", forced_clear = "Native goalkeeper clear is active",
        no_possession = "Waiting for native ball possession or a confirmed volley",
        invalid_sample = "Waiting for a valid camera aim", no_world = "Shot boundary data unavailable",
        no_launch = "Ball launch point unavailable", no_goal = "Attacking goal unavailable",
        invalid_goal = "Outside the attacking side of the goal",
    }
    local function _iz(reason)
        if _ii then _ii.reason = reason end
        _it(reason == "no_possession" and "WAITING FOR BALL" or "NORMAL AIM", _iy[reason])
        return nil
    end
    local function eligible()
        if not (alive and A.Enabled and d.alive()) or d.uiBusy() then return false, "suspended" end
        if d.Input:GetFocusedTextBox() then return false, "suspended" end
        local ch = d.Player.Character
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return false, "no_character" end
        if d.M.Match.IsGoalkeeperCharacter(ch) then return false, "goalkeeper" end
        if N.Client.IsForcedClearCharging() then return false, "forced_clear" end
        if not (ownsBall() or N.Client.IsVolleyCharging()) then return false, "no_possession" end
        return true
    end
    local function _ja(origin)
        local _jb = N.Tutorial.GetGoalPart()
        local practiceGoals = not _jb and d.M.Practice.GetGoalParts() or nil
        local _jc = _jb and { _jb } or practiceGoals
        local team = d.M.Teams.GetActorTeamName(d.Player)
        if not _jc then
            if not d.M.Match.Constants.TeamDisplayNames[team] then return nil end
            local map = workspace:FindFirstChild("Map")
            local data = map and map:FindFirstChild("Data")
            local side = data and data:FindFirstChild(d.M.Match.GetOpposingTeamName(team))
            local goal = side and side:FindFirstChild("Goal")
            _jc = goal and { goal } or nil
        end
        local best, distance
        for _, goal in ipairs(_jc or {}) do
            if goal:IsA("BasePart") then
                local delta = (goal.Position - origin).Magnitude
                if not distance or delta < distance then best, distance = goal, delta end
            end
        end
        return best, team, practiceGoals
    end
    local function _jd(goal, origin)
                                                                               
        local cf, size = goal.CFrame, goal.Size
        local forward = size.X < size.Z and cf.RightVector or cf.LookVector
        forward = flat(forward)
        if forward.Magnitude < 0.9 then return nil end
        forward = forward.Unit
        if (origin - goal.Position):Dot(forward) < 0 then forward = -forward end
        local lateral = forward:Cross(_ip)
        local depth = math.abs(forward:Dot(cf.RightVector)) * size.X / 2
            + math.abs(forward:Dot(cf.LookVector)) * size.Z / 2
        return { center = goal.Position, plane = goal.Position + forward * depth,
            forward = forward, lateral = lateral,
            halfWidth = (math.abs(lateral:Dot(cf.RightVector)) * size.X
                + math.abs(lateral:Dot(cf.LookVector)) * size.Z) / 2,
            bottom = goal.Position.Y - size.Y / 2, top = goal.Position.Y + size.Y / 2 }
    end
    local function _je(mouth, origin)
                                                                                                   
        local offset = math.clamp((origin - mouth.plane):Dot(mouth.lateral), -mouth.halfWidth, mouth.halfWidth)
        return flat(origin - (mouth.plane + mouth.lateral * offset)).Magnitude
    end
    local function _jf(character, root, hum, cf, velocity)
        local state = d.M.Controllers.GetHumanoidState(character, hum)
        local airborne = state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall
        local floor = d.M.Grounding.GetStandingY(hum, root)
        local gravity = math.max(workspace.Gravity, 1)
        local jump = hum.UseJumpPower and hum.JumpPower or math.sqrt(2 * gravity * hum.JumpHeight)
        local _jg = airborne and math.max(0, (velocity.Y + math.sqrt(velocity.Y ^ 2
            + 2 * gravity * math.max(0, cf.Position.Y - floor))) / gravity) or 0
        local _jh = N.ActionMovement.GetRunWalkSpeed(N.ActionMovement.GetBaseWalkSpeed(), false)
        local _ji = N.Receiving.GetReceiveHitbox(character, false)
        local _jj = N.Receiving.GetReceiveHitbox(character, true)
        local _jk = N.Tackle.Constants
        local untilTime = N.Tackle.GetSlidingUntil(character)
                                                                                     
        local _jl = untilTime and math.max(0, workspace:GetServerTimeNow() - (untilTime - _jk.TotalMotionSeconds)) or nil
        local direction = flat(velocity)
        if direction.Magnitude <= 0.5 then direction = flat(cf.LookVector) end
        direction = direction.Magnitude > 1e-5 and direction.Unit or Vector3.new(0, 0, -1)
        local function _jm(box)
            return { Size = box.Size + Vector3.new(1, 1, 1) * (d.M.Physics.BallRadius * 2),
                CFrameOffset = box.CFrameOffset, Shape = box.Shape }
        end
        return { character = character, position = cf.Position, cf = cf, root = { CFrame = cf },
            tilted = cf.UpVector.Y < 0.98,
            velocity = velocity, speed = math.max(_jh, hum.WalkSpeed, _jl and 0 or flat(velocity).Magnitude),
            jump = math.max(0, jump), floor = floor, gravity = gravity, landAt = _jg,
            receive = _jm(_ji), airReceive = _jm(_jj), tackle = _jm(d.M.Hitboxes.SlideTackle),
            slideAge = _jl, slideDirection = direction, slideConstants = table.clone(_jk) }
    end
    local function _jn(ch, team, goal, practiceGoals)
        local _jo, defenders, seen = {}, {}, {}
        local context = d.M.Motion.GetContext(ch)
        local opposing = not practiceGoals and d.M.Match.Constants.TeamDisplayNames[team]
            and type(d.M.Match.GetOpposingTeamName) == "function"
            and d.M.Match.GetOpposingTeamName(team) or nil
        local function add(character, actor)
            if not character or character == ch or seen[character] then return end
            seen[character] = true
            if d.M.Motion.GetContext(character) ~= context then return end
            local _jp = d.M.Match.IsGoalkeeperCharacter(character)
            local otherTeam = d.M.Teams.GetActorTeamName(actor or character)
            if not _jp and (not opposing or otherTeam ~= opposing) then return end
                                                                                           
            if not practiceGoals then
                if team and otherTeam == team then return end
            end
            local root = character:FindFirstChild("HumanoidRootPart")
            local hum = character:FindFirstChildOfClass("Humanoid")
            if not root or not hum or hum.Health <= 0 or (root.Position - goal.Position).Magnitude > 150 then return end
            local cf = d.M.Motion.GetCFrame(character) or root.CFrame
            if not _ir(cf.Position) then return end
            if practiceGoals then
                                                                                         
                                                                                                
                                                                                 
                local _jq = (cf.Position - goal.Position).Magnitude
                for _, otherGoal in ipairs(practiceGoals) do
                    if otherGoal ~= goal and otherGoal:IsA("BasePart")
                        and (cf.Position - otherGoal.Position).Magnitude + 1 < _jq then
                        return
                    end
                end
            end
            local velocity = d.M.Motion.GetVelocity(character) or root.AssemblyLinearVelocity
            if not _ir(velocity) then velocity = _io end
            if not _jp then
                table.insert(defenders, _jf(character, root, hum, cf, velocity))
                return
            end
            local jump = hum.UseJumpPower and hum.JumpPower or math.sqrt(2 * workspace.Gravity * hum.JumpHeight)
            table.insert(_jo, { position = cf.Position, velocity = velocity,
                speed = math.max(24, hum.WalkSpeed, flat(velocity).Magnitude),
                jump = math.max(0, jump), character = character,
                upright = cf.UpVector.Y > 0.98 })
        end
        for _, _j in ipairs(d.Players:GetPlayers()) do add(_j.Character, _j) end
                                                                         
                                                                                                   
        local folder = workspace:FindFirstChild("Characters")
        local function _jr(container)
            if not container then return end
            for _, child in ipairs(container:GetChildren()) do
                if child:IsA("Model") then add(child) end
            end
        end
        _jr(folder)
        _jr(folder and folder:FindFirstChild("NPCs"))
        return _jo, defenders
    end
    local function frame(sample, releaseDelay)
        local _js = releaseDelay ~= nil
        if not _ii or (_ii.locked and not _js) then return nil end
        local allowed, reason = eligible()
        if not allowed then return _iz(reason) end
        local ch = d.Player.Character
        local root = ch and ch:FindFirstChild("HumanoidRootPart")
        if not root then return _iz("no_character") end
        if typeof(sample) ~= "table" or not _ir(sample.Origin)
            or not _ir(sample.Direction) or typeof(sample.CameraCFrame) ~= "CFrame" then return _iz("invalid_sample") end
        local world = N.Preview.GetChargeBoundaryWorld(d.Player)
        local origin = N.Carry.GetLaunchPosition(ch)
        if not world then return _iz("no_world") end
        if not _ir(origin) then return _iz("no_launch") end
        origin = d.M.Physics.GetContainedGroundPosition(origin, d.M.Physics.BallRadius, world)
        local goal, team, practiceGoals = _ja(origin)
        if not goal then return _iz("no_goal") end
        local mouth = _jd(goal, origin)
        if not mouth or (origin - mouth.plane):Dot(mouth.forward) <= 0.2 then return _iz("invalid_goal") end
        _ii.distance = _je(mouth, origin)
        if _ii.distance > C.MaxAssistDistance then
            _ii.reason = "out_of_range"
            _it("OUT OF RANGE", string.format("%.2f / %d studs | Normal aim", _ii.distance, C.MaxAssistDistance))
            return nil
        end
        local constants = _ii.constants or N.Power.GetChargeConstants(ch, N.Shoot.Constants.Kick)
        _ii.constants = constants
        local elapsed = math.max(0, os.clock() - _ii.started)
        if _js then
                                                                                       
            if not _iq(_ii.chargeStartedAt) then return nil end
            elapsed = d.M.Clock.GetSmoothedServerTime() - _ii.chargeStartedAt
            if not _iq(elapsed) or elapsed < 0 then return nil end
        end
        local minimum = N.Core.GetMinimumReleaseSeconds(constants)
        local maximum = constants.MaximumChargeSeconds
        local _jt = math.clamp(math.max(minimum, elapsed), minimum, maximum)
        local _ju = math.max(minimum, maximum - N.Core.Constants.AimLockSeconds)
                                                                                          
        local _jv = not ownsBall() and N.Client.IsVolleyCharging()
        _ii.volley = _jv
        local remaining, imminent = 0, true
        if _jv then
            if _ii.volleyRefused or not N.Volley.CanPredictVolleyLaunch(d.Player) then
                _ii.reason = "waiting_volley"
                _it("WAITING FOR PASS", "Native volley claim is not confirmed | Normal aim")
                return nil
            end
            remaining = N.Volley.GetReleaseRemainingSeconds(d.Player, _ii.volleyArrival)
            if not _iq(remaining) or remaining > C.VolleyPrepareSeconds then
                _ii.reason = "waiting_volley"
                _it("WAITING FOR PASS", "Aim will be checked near the native volley arrival")
                return nil
            end
            remaining = math.max(0, remaining)
            _jw = N.Volley.IsStrikeImminent(d.Player, _ii.volleyArrival)
            _jt = math.clamp(math.max(minimum, elapsed + remaining), minimum, maximum)
        end
                                                                                                  
        local _jx = not _js and not _jv and not _ii.releasing and elapsed >= _ju - 0.08
        local _jy = _jx and { _ju, (_ju + maximum) / 2, maximum } or { _jt }
        local velocity = flat(root.AssemblyLinearVelocity)
        local lead = _jv and math.max(remaining, minimum - elapsed, 0)
            or (_jx and math.max(0, maximum - elapsed) or math.max(0, minimum - elapsed))
        if _js then
            if _jv then return nil end
            _jt = math.clamp(elapsed + releaseDelay, minimum, maximum)
            _jy = { _jt }
            lead = math.max(releaseDelay, minimum - elapsed, 0)
        end
        local _jz = origin
        local delta = velocity * lead
        local _ka
        if sample.IsAirborne and lead > 0 then
            local hum = ch:FindFirstChildOfClass("Humanoid")
            local floor = d.M.Grounding.GetStandingY(hum, root)
            _ka = { y = root.Position.Y, velocityY = root.AssemblyLinearVelocity.Y, floor = floor }
            local y = math.max(floor, root.Position.Y + root.AssemblyLinearVelocity.Y * lead - workspace.Gravity * lead * lead / 2)
            delta += Vector3.new(0, y - root.Position.Y, 0)
        end
                                                                                       
                                                                                                          
        origin = d.M.Physics.GetContainedGroundPosition(origin + delta, d.M.Physics.BallRadius, world)
        delta = origin - _jz
        _ii.distance = math.max(_ii.distance, _je(mouth, origin))
        if _ii.distance > C.MaxAssistDistance then
            _ii.reason = "out_of_range"
            _it("OUT OF RANGE", "Predicted release leaves the close-range zone | Normal aim")
            return nil
        end
        local curve = N.Curves.IsEnabled() and (_ii.curve or 0) or 0
        local _kb, defenders = _jn(ch, team, goal, practiceGoals)
        return { character = ch, root = root, origin = origin, velocity = velocity,
            sample = sample, goal = goal, goalCF = goal.CFrame, world = world, mouth = mouth,
            charge = _jx and maximum or _jt, charges = _jy,
            minimumCharge = minimum, maximumCharge = maximum,
            elapsed = elapsed,
            lead = lead, aimOffset = delta, volley = _jv, canApply = _jw,
            releaseProjection = _jx and { origin = _jz, airborne = _ka, reachProfiles = {} } or nil,
            distance = _ii.distance, arrivalRemaining = remaining,
            curve = curve, autoCurve = _ii.autoCurve == true and N.Curves.IsEnabled() and N.Curves.GetPower() > 0,
            boost = N.Power.GetMultiplier(ch), curvePower = N.Curves.GetPower(),
            keepers = _kb, defenders = defenders, at = d.M.Clock.GetSmoothedServerTime(),
            radius = d.M.Physics.BallRadius, clock = os.clock(), team = team,
            context = d.M.Motion.GetContext(ch), ballId = ballId() }
    end
    local function _kc(f, yaw, pitch)
        local aim = table.clone(f.sample)
        aim.Direction = Vector3.new(math.sin(yaw) * math.cos(pitch), math.sin(pitch), math.cos(yaw) * math.cos(pitch))
                                                                                      
        aim.ClientHit, aim.TargetPosition = nil, nil
        return aim
    end
    local function _kd(direction)
        return math.atan2(direction.X, direction.Z), math.atan2(direction.Y, flat(direction).Magnitude)
    end
    local function _ke(f, aim, _jt)
        local kick = flat(aim.Direction)
        if kick.Magnitude < 1e-6 then return nil end
        stats.evaluations += 1
        local _kf = table.clone(aim)
        _kf.Origin += f.aimOffset or _io
        _kf.CameraCFrame += f.aimOffset or _io
        local velocity = N.RawLaunch(f.character, _jt or f.charge,
            d.M.Actions.PassTypes.Shot, _kf, f.origin, f.velocity, kick.Unit, nil,
            f.boost, f.world, nil, f.curve)
        if not _ir(velocity) then return nil end
        local spin = N.RawSpin(f.character, velocity, f.velocity, f.curve, _jt or f.charge)
        if not _ir(spin) then return nil end
        return velocity, spin
    end
    local function _kg(f, velocity, spin)
        local mouth = f.mouth
        local _kh = (f.origin - mouth.plane):Dot(mouth.forward)
        local _ki, lastD = 0, _kh
        for t = 0.10, C.Horizon + 0.001, 0.10 do
            local _kk = d.M.Physics.GetAirFlight(f.origin, velocity, spin, t)
            local distance = (_kk - mouth.plane):Dot(mouth.forward)
            if _kj > 0 and distance <= 0 then
                local _kl, hi = _ki, t
                for _ = 1, 9 do
                    local _kn = (_kl + _km) / 2
                    local p = d.M.Physics.GetAirFlight(f.origin, velocity, spin, _kn)
                    if (p - mouth.plane):Dot(mouth.forward) > 0 then _kl = _kn else _km = _kn end
                end
                local hit = d.M.Physics.GetAirFlight(f.origin, velocity, spin, (_kl + _km) / 2)
                return Vector2.new((hit - mouth.center):Dot(mouth.lateral), hit.Y), (_kl + _km) / 2
            end
            _ki, lastD = t, distance
        end
        return nil
    end
    local function _ko(f, yaw, pitch)
        local aim = _kc(f, yaw, pitch)
        local velocity, spin = _ke(f, aim)
        local hit = velocity and _kg(f, velocity, spin)
        coroutine.yield()
        return hit
    end
    local function _kp(f, target, seed)
        local point = f.mouth.center + f.mouth.lateral * target.X
        point = Vector3.new(point.X, target.Y, point.Z)
        local direction = point - (f.sample.Origin + (f.aimOffset or _io))
        if direction.Magnitude < 1e-4 then return nil end
        local yaw, pitch = _kd(direction.Unit)
        local _kq, directPitch = yaw, pitch
        local _ks = false
                                                                                      
                                                                                                    
        if seed and seed.hit and (target - seed.hit).Magnitude <= 8 then
            local error2 = target - seed.hit
            local determinant = seed.dx.X * seed.dy.Y - seed.dy.X * seed.dx.Y
            if math.abs(determinant) > 1e-5 then
                yaw = seed.yaw + math.clamp((error2.X * seed.dy.Y - seed.dy.X * error2.Y) / determinant, -0.6, 0.6)
                pitch = math.clamp(seed.pitch + math.clamp((seed.dx.X * error2.Y - error2.X * seed.dx.Y) / determinant, -0.45, 0.45), -1.25, 1.25)
                _ks = true
            end
        end
        local _kt, bestAim = math.huge, nil
        for _ = 1, 4 do
            local hit = _ko(f, yaw, pitch)
            if not hit and _ks then
                yaw, pitch, seeded = _kq, _kr, false
                hit = _ko(f, yaw, pitch)
            end
            if not hit then return _ku end
            local error2 = target - hit
            if error2.Magnitude < _kt then _kt, bestAim = error2.Magnitude, _kc(f, yaw, pitch) end
            if _kt < 0.30 then break end
            local _kv = 0.012
            local _kw, hy = _ko(f, yaw + _kv, pitch), _ko(f, yaw, pitch + _kv)
            if not _kw or not _kx then break end
            local dx, dy = (_kw - hit) / _kv, (_kx - hit) / _kv
            local determinant = dx.X * dy.Y - dy.X * dx.Y
            if math.abs(determinant) < 1e-5 then break end
            if seed then
                seed.hit, seed.yaw, seed.pitch, seed.dx, seed.dy = hit, yaw, pitch, dx, dy
            end
            yaw += math.clamp((error2.X * dy.Y - dy.X * error2.Y) / determinant, -0.25, 0.25)
            pitch = math.clamp(pitch + math.clamp((dx.X * error2.Y - error2.X * dx.Y) / determinant, -0.2, 0.2), -1.25, 1.25)
        end
        return _ku
    end
    local function _ky(seconds, speed)
        local dive, assist = d.M.Dive.Constants, d.M.Assist.Constants
        local distance = dive.Distance + assist.MaximumExtraReachStuds
        local scale, duration = assist.MaximumTravelScale, dive.DurationSeconds
                                                                                                   
                                                                                              
        local peak = duration / scale * (1 - math.sqrt(speed * duration / (3 * distance * scale)))
        local _kz = math.clamp(peak, 0, math.min(seconds, dive.HitboxCurveSeconds))
        return math.max(speed * seconds,
            d.M.Dive.GetTravel(_kz * scale, distance) + speed * (seconds - _kz))
    end
    local function _la(f, first, second, t)
        local _lb = math.huge
        local dive = d.M.Dive.Constants
        local assist = d.M.Assist.Constants
        local box = d.M.Hitboxes.AirReceive
        local padding = math.max(d.M.Contacts.Constants.ContactPadding, f.radius * 2)
                                                                                   
        local _lc = (box.Size + Vector3.new(padding, padding, padding)).Magnitude / 2
            + box.CFrameOffset.Position.Magnitude
        local _ld = _lc
        for _, _jp in ipairs(f.keepers) do
                                                                                               
                                                                                  
            local lead = t + f.lead + C.NetworkMargin
            local radius = _lc + _ky(lead, _jp.speed)
            local delta = flat(second - first)
            local _le = flat(_jp.position - first)
            local alpha = delta:Dot(delta) > 1e-8 and math.clamp(_le:Dot(delta) / delta:Dot(delta), 0, 1) or 0
            local _lf = first:Lerp(second, alpha)
            local horizontal = flat(_lf - _jp.position).Magnitude - radius
            local _lg = _jp.jump ^ 2 / math.max(2 * workspace.Gravity, 1)
            local top = _jp.position.Y + _ld + _lg
                + math.max(0, _jp.velocity.Y) * lead
                + (dive.InitialVerticalVelocity + assist.MaximumVerticalVelocityChange) * math.min(t, dive.HitboxCurveSeconds)
            local _lh = _jp.position.Y - _ld - workspace.Gravity * lead * lead / 2
            local vertical = math.max(math.min(first.Y, second.Y) - top, _lh - math.max(first.Y, second.Y))
            _lb = math.min(_lb, math.max(horizontal, vertical))
        end
        return _lb
    end
    local function _li(f, _jp, t)
        local dive, assist = d.M.Dive.Constants, d.M.Assist.Constants
        local box = d.M.Hitboxes.AirReceive
        local padding = math.max(d.M.Contacts.Constants.ContactPadding, f.radius * 2)
        local offset = box.CFrameOffset.Position
        local halfWidth = math.max(box.Size.X, box.Size.Z) / 2 + padding / 2 + flat(offset).Magnitude
        local _lj = offset.Y + (box.Size.Y + padding) / 2
        local gravity = math.max(workspace.Gravity, 1)
        local available = math.max(0, t + f.lead + C.NetworkMargin)
        local _lk = math.min(available, dive.HitboxCurveSeconds)
        local distance = dive.Distance + assist.MaximumExtraReachStuds
        local scale = assist.MaximumTravelScale
        local function jumpRise(seconds)
                                                                           
            local speed = math.max(_jp.jump, _jp.velocity.Y, 0)
            local elapsed = math.min(seconds, speed / gravity)
            return math.max(0, speed * elapsed - 0.5 * gravity * elapsed * elapsed)
        end
        local profile = { halfWidth + _jp.speed * available, _lj + jumpRise(available) }
        local function add(_kz)
            local before = available - _kz
            local radius = halfWidth + _jp.speed * before + d.M.Dive.GetTravel(_kz * scale, distance)
            local rise = math.max(0, dive.InitialVerticalVelocity * _kz
                + 0.5 * (dive.GravityStudsPerSecondSquared or -65) * _kz * _kz)
                                                                                       
            local _ll = assist.MaximumVerticalVelocityChange * _kz
                / (1 + 0.5 * (assist.LiftGravityPerStud or 15) * _kz * _kz)
            profile[#profile + 1] = radius
            profile[#profile + 1] = _lj + jumpRise(before) + rise + _ll
        end
        for i = 0, 6 do add(_lk * i / 6) end
                                                                                     
        local peak = dive.DurationSeconds / scale
            * (1 - math.sqrt(_jp.speed * dive.DurationSeconds / (3 * distance * scale)))
        add(math.clamp(peak, 0, _lk))
        return profile
    end
    local function _lm(f, first, second, t)
                                                                                 
                                                                                   
                                                                                   
                                                                                       
        local cache = f.reachProfiles
        if not cache then cache = {}; f.reachProfiles = cache end
        local profiles = cache[t]
        if not profiles then profiles = {}; cache[t] = profiles end
        local _ln = flat(second - first)
        local lengthSquared = _ln:Dot(_ln)
        local lowY = math.min(first.Y, second.Y)
        local minimum, difficulty = math.huge, math.huge
        for _, _jp in ipairs(f.keepers) do
            if _jp.upright == false then
                local _lo = math.max(0, 1 + _la(f, first, second, t) / d.M.Dive.Constants.Distance)
                return _lo, _lo
            end
            local alpha = lengthSquared > 1e-8
                and math.clamp(flat(_jp.position - first):Dot(_ln) / lengthSquared, 0, 1) or 0
            local _lp = flat(first:Lerp(second, alpha) - _jp.position).Magnitude
            local profile = profiles[_jp]
            if not profile then profile = _li(f, _jp, t); profiles[_jp] = profile end
            local best = math.huge
            local height = math.max(0, lowY - _jp.position.Y)
            for i = 1, #profile, 2 do
                                                                                    
                                                                                     
                                                              
                local horizontal = _lp / math.max(profile[i], 0.01)
                local vertical = height / math.max(profile[i + 1], 0.01)
                best = math.min(best, math.max(horizontal, vertical))
                                                                                       
                                                                                        
                                                                                             
                difficulty = math.min(difficulty, math.max(horizontal, vertical)
                    + 0.20 * math.min(horizontal, vertical))
            end
            minimum = math.min(minimum, best)
        end
        return minimum, difficulty
    end
    local function _lq(defender, seconds)
        local horizontal = flat(defender.velocity) * seconds
        if defender.slideAge then
            local c = defender.slideConstants
            local travel = N.Tackle.GetMaximumTravelBetween(defender.slideAge,
                defender.slideAge + seconds, c.StartupDashDistance, c.Distance)
            horizontal = defender.slideDirection * travel
        end
        local y = defender.floor
        if seconds < defender.landAt then
            y = math.max(y, defender.position.Y + defender.velocity.Y * seconds - defender.gravity * seconds * seconds / 2)
        end
        return horizontal + _ip * (y - defender.position.Y)
    end
    local function _lr(f, defender, _dk, _dm)
        local cache = f.defenderProfiles
        if not cache then cache = {}; f.defenderProfiles = cache end
        local _ls = cache[_dm]
        if not _ls then _ls = {}; cache[_dm] = _ls end
        local cached = _ls[defender]
        if cached and cached.t0 == _dk then return cached end
        local a, b = f.lead + _dk, f.lead + _dm
        local _lt, offset1 = _lq(defender, a), _lq(defender, b)
        local _lv, airborne1 = a < defender.landAt, b < defender.landAt
        local _lx = _lv and defender.airReceive or defender.receive
        local _ly = _lw and defender.airReceive or defender.receive
        local available = math.max(0, b + C.NetworkMargin)
        local _lz = math.min(math.max(0, available - defender.landAt), defender.jump / defender.gravity)
        local jumpRise = math.max(0, defender.jump * _lz - defender.gravity * _lz * _lz / 2)
        local _ma = defender.receive.CFrameOffset.Y + defender.receive.Size.Y / 2
        local _mb = defender.airReceive.CFrameOffset.Y + defender.airReceive.Size.Y / 2
        local _mc = defender.receive.CFrameOffset.Y - defender.receive.Size.Y / 2
        local _md = defender.airReceive.CFrameOffset.Y - defender.airReceive.Size.Y / 2
        local low = math.min(defender.position.Y + _lt.Y + (_lv and _md or _mc),
            defender.position.Y + _lu.Y + (_lw and _md or _mc))
        local high = math.max(defender.position.Y + _lt.Y + (_lv and _mb or _ma),
            defender.position.Y + _lu.Y + (_lw and _mb or _ma))
        if available > defender.landAt then high = math.max(high, defender.floor + _mb + jumpRise) end
        local halfWidth = math.max(defender.receive.Size.X, defender.receive.Size.Z,
            defender.airReceive.Size.X, defender.airReceive.Size.Z) / 2
        local horizontal = defender.speed * available
        local _me, _mf, _mg
        local c = defender.slideConstants
        if defender.slideAge then
                                                                                  
                                                                               
            horizontal = math.max(horizontal, flat(_lu).Magnitude)
            _mf = math.max(a, c.HitboxDelaySeconds - defender.slideAge)
            _mg = math.min(b, c.HitboxDelaySeconds + c.HitboxSeconds - defender.slideAge)
            if _mf <= _mg then
                _me = N.Tackle.GetMaximumTravelBetween(defender.slideAge,
                    defender.slideAge + _mg, c.StartupDashDistance, c.Distance)
            end
        else
                                                                                  
                                                                                      
            local _mh = math.min(c.HitboxDelaySeconds + c.HitboxSeconds, available - defender.landAt)
            if _mh >= c.HitboxDelaySeconds then
                for i = 0, 4 do
                    local age = c.HitboxDelaySeconds + (_mh - c.HitboxDelaySeconds) * i / 4
                    local travel = N.Tackle.GetMaximumTravelBetween(0, age, c.StartupDashDistance, c.Distance)
                    _me = math.max(_me or 0, defender.speed * (available - age) + travel)
                end
            end
        end
        if _me then
            local box = defender.tackle
            _me += flat(box.CFrameOffset.Position).Magnitude + math.sqrt(box.Size.X ^ 2 + box.Size.Z ^ 2) / 2
        end
        cached = { t0 = _dk, a = a, b = b, offset0 = _lt, offset1 = _lu,
            box0 = _lx, box1 = _ly, radius = horizontal + halfWidth, low = low, high = high,
            slideReach = _me, slideLow = defender.floor + defender.tackle.CFrameOffset.Y - defender.tackle.Size.Y / 2,
            slideHigh = defender.floor + defender.tackle.CFrameOffset.Y + defender.tackle.Size.Y / 2,
            slideWindow0 = _mf, slideWindow1 = _mg }
        _ls[defender] = cached
        return cached
    end
    local function _mi(f, first, second, _dk, _dm)
        if not f.defenders or #f.defenders == 0 then return math.huge, 0 end
        local dx, dz = second.X - first.X, second.Z - first.Z
        local lengthSquared = dx * dx + dz * dz
        local lowY, highY = math.min(first.Y, second.Y), math.max(first.Y, second.Y)
        local minimum, risk = math.huge, 0
        for _, defender in ipairs(f.defenders) do
            local p = _lr(f, defender, _dk, _dm)
            local x, z = first.X - defender.position.X, first.Z - defender.position.Z
            local alpha = lengthSquared > 1e-8
                and math.clamp(-(x * dx + z * dz) / lengthSquared, 0, 1) or 0
            x, z = x + dx * alpha, z + dz * alpha
            local distance = math.sqrt(x * x + z * z)
            local vertical = math.max(lowY - p.high, p.low - _mj, 0)
            local value = math.max(distance / math.max(p.radius, 0.01), vertical > 0 and 1 + vertical / 4 or 0)
            if p.slideReach then
                vertical = math.max(lowY - p.slideHigh, p.slideLow - _mj, 0)
                value = math.min(value, math.max(distance / math.max(p.slideReach, 0.01), vertical > 0 and 1 + vertical / 4 or 0))
            end
            minimum = math.min(minimum, value)
            if value <= 1 then risk = math.max(risk, 1) end
                                                                                
                                                                                  
            local _mk = false
            if risk < 2 and (value <= 1 or defender.tilted) then
                local _ml, to = first - p.offset0, second - p.offset1
                if p.box1 ~= p.box0 then
                                                                                
                                                                      
                    local _mn = math.clamp((defender.landAt - p.a) / math.max(p.b - p.a, 1e-8), 0, 1)
                    local _mo = first:Lerp(second, _mn) - _lq(defender, defender.landAt)
                    _mk = d.M.Hitboxes.GetSegmentEnterAlpha(defender.root, p.box0, _ml, _mo) ~= nil
                        or d.M.Hitboxes.GetSegmentEnterAlpha(defender.root, p.box1, _mo, _mm) ~= nil
                else
                    _mk = d.M.Hitboxes.GetSegmentEnterAlpha(defender.root, p.box0, _ml, _mm) ~= nil
                end
                if not _mk and p.slideWindow0 and p.slideWindow0 <= p.slideWindow1 then
                    local duration = math.max(p.b - p.a, 1e-8)
                    local _mp = first:Lerp(second, (p.slideWindow0 - p.a) / duration) - _lq(defender, p.slideWindow0)
                    local _mq = first:Lerp(second, (p.slideWindow1 - p.a) / duration) - _lq(defender, p.slideWindow1)
                    _mk = d.M.Hitboxes.GetSegmentEnterAlpha(defender.root, defender.tackle, _mp, _mq) ~= nil
                end
            end
            if _mk then risk = 2 end
        end
        return minimum, risk
    end
    local function _mr(a, b)
        if not a then return false end
        if not b then return true end
        local ar, br = a.defenderRisk or 0, b.defenderRisk or 0
        if ar ~= br then return ar < br end
        return a.score > b.score
    end
    local function _ms(f, hits)
        if not hits then return false end
                                                                                
                                                                                  
        local _mt = f.groundParts
        if not _mt then
            _mt = {}
            for _, solid in ipairs(f.world.GroundSolids or {}) do
                if solid.Part then _mt[solid.Part] = true end
            end
            f.groundParts = _mt
        end
        local constants = d.M.Physics.Constants
        local _mu = constants and constants.Solver and constants.Solver.MinimumGroundNormalY or 0.55
        for _, hit in ipairs(hits) do
            local normal = hit.FaceNormal or hit.Normal
            if not _mt[hit.Part] or not _ir(normal) or normal.Y < _mu then return true end
        end
        return false
    end
    local function _mv(mouth, position)
                                                                              
                                                                           
        local height = math.clamp((position.Y - mouth.bottom) / math.max(mouth.top - mouth.bottom, 0.01), 0, 1)
        local width = math.clamp(math.abs((position - mouth.center):Dot(mouth.lateral)) / math.max(mouth.halfWidth, 0.01), 0, 1)
        return 0.20 * height * width
    end
    local function _mw(f, aim, _jt, yielding)
        local velocity, spin = _ke(f, aim, _jt)
        if yielding then coroutine.yield() end
        if not velocity then return nil end
        local _mx = f.at + f.lead
        local state = d.M.Physics.NewState(f.origin, velocity, f.radius, _mx, spin)
        local position, time = d.M.Prediction.GetGoalCrossing(state, f.world, f.goal, _mx, C.Horizon)
        if yielding then coroutine.yield() end
        if not _ir(position) or not _iq(time) then return nil end
        local eta = time - _mx
        if eta <= 0 or eta > C.Horizon then return nil end
        local mouth = f.mouth
        local _my = math.min(mouth.halfWidth - math.abs((position - mouth.center):Dot(mouth.lateral)), mouth.top - position.Y)
                                                                                
                                                                                
        if position.Y < mouth.bottom then return nil end
        if _my - f.radius < C.EdgeMargin then return nil, position end
        local _mz, _na, _nb, previous = math.huge, math.huge, math.huge, f.origin
        local defenderReach, defenderRisk, previousT = math.huge, 0, 0
        local _nd = state
        local count = math.ceil(eta / C.Step)
        for i = 1, count do
                                                                                     
                                                                            
            local t = math.min(C.Step * i, eta)
            _nd = d.M.Physics.GetStateAtTime(_nd, _mx + t, f.world, {})
            if not _nd or not _ir(_nd.Position) then return nil end
            if _ms(f, _nd.BoundaryHits) then return nil end
            _mz = math.min(_mz, _la(f, previous, _nd.Position, t))
            local _ne, difficulty = _lm(f, previous, _nd.Position, t)
            _na, minDifficulty = math.min(_na, _ne), math.min(_nb, difficulty)
            local _nf, risk = _mi(f, previous, _nd.Position, _nc, t)
            defenderReach, defenderRisk = math.min(defenderReach, _nf), math.max(defenderRisk, risk)
            _nc = t
            previous = _nd.Position
            if yielding and i % 8 == 0 then coroutine.yield() end
        end
                                                                                 
                                                                           
        _my = math.min(_my, mouth.halfWidth - math.abs((_nd.Position - mouth.center):Dot(mouth.lateral)),
            mouth.top - _nd.Position.Y)
        if _my - f.radius < C.EdgeMargin then return nil, _nd.Position end
        if #f.keepers == 0 then _mz, _na, minDifficulty = nil, nil, nil end
        return { gap = _mz, reachDemand = _na, difficulty = _nb, predictionCharge = _jt,
            score = (_nb and (_nb - 1) * d.M.Dive.Constants.Distance or 0)
                - eta * 0.35 + math.min(_my, 2) * 0.08
                + _mv(mouth, position)
                - math.clamp(1 - defenderReach, 0, 1) * d.M.Dive.Constants.Distance,
            defenderDemand = defenderReach < math.huge and defenderReach or nil, defenderRisk = defenderRisk,
            eta = eta, position = position, keepers = #f.keepers, edgeClearance = _my - f.radius }
    end
    local function _ng(f, _jt)
        local _nh = f.releaseProjection
        if not _nh then return f end
        local lead = math.max(0, _jt - f.elapsed)
        if math.abs(lead - f.lead) < 1e-8 then return f end
        local at = table.clone(f)
        local delta = f.velocity * lead
        local _ni = _nh.airborne
        if _ni then
            local y = math.max(_ni.floor, _ni.y + _ni.velocityY * lead - workspace.Gravity * lead * lead / 2)
            delta += Vector3.new(0, y - _ni.y, 0)
        end
        at.origin = d.M.Physics.GetContainedGroundPosition(_nh.origin + delta, f.radius, f.world)
        at.aimOffset, at.lead = at.origin - _nh.origin, lead
                                                                                          
        local profiles = _nh.reachProfiles[lead]
        if not profiles then profiles = {}; _nh.reachProfiles[lead] = profiles end
        at.reachProfiles = profiles
        return at
    end
    local function _nj(f, aim, yielding)
        local _nk, _nl, _nm, defenderReach, defenderRisk
        for _, _jt in ipairs(f.charges) do
                                                                                     
                                                                                     
            local result, edgePosition = _mw(_ng(f, _jt), aim, _jt, yielding)
            if not result then return nil, edgePosition end
            if result.gap ~= nil then _nl = math.min(_nl or math.huge, result.gap) end
            _nm = math.min(_nm or math.huge, result.edgeClearance)
            if result.defenderDemand then defenderReach = math.min(defenderReach or math.huge, result.defenderDemand) end
            defenderRisk = math.max(defenderRisk or 0, result.defenderRisk or 0)
                                                                              
                                                                                   
                                                                       
            if not _nk or math.abs(_jt - f.charge) < math.abs(_nk.predictionCharge - f.charge) then _nk = result end
        end
        if _nk then
            _nk.gap, _nk.edgeClearance = _nl, _nm
            _nk.defenderDemand, _nk.defenderRisk = defenderReach, defenderRisk
        end
        return _nk
    end
    local function _nn(a, b)
        return a and b and a.character == b.character and a.goal == b.goal and a.goalCF == b.goalCF
                                                                                 
                                                                                              
            and a.context == b.context and a.ballId == b.ballId and a.team == b.team
            and a.curve == b.curve and a.autoCurve == b.autoCurve and a.boost == b.boost and a.curvePower == b.curvePower
            and a.volley == b.volley and a.sample.IsAirborne == b.sample.IsAirborne and (a.origin - b.origin).Magnitude < 8
                                                                                      
                                                                                            
    end
    local function _no(entry, f)
        local direction = entry.direction
        local _np = entry.frame.sample.Origin + (entry.frame.aimOffset or _io)
        local origin = f.sample.Origin + (f.aimOffset or _io)
        local _nq = direction:Dot(f.mouth.forward)
                                                                                            
                                                                                                         
        if (origin - _np).Magnitude > 1e-5 and math.abs(_nq) > 1e-5 then
            local distance = (f.mouth.plane - _np):Dot(f.mouth.forward) / _nq
            local delta = _np + direction * distance - origin
            if distance > 0 and _ir(delta) and delta.Magnitude > 1e-5 then direction = delta.Unit end
        end
        local yaw, pitch = _kd(direction)
        return _kc(f, yaw, pitch)
    end
    local function _nr(f, aim, position)
                                                                                
                                                                                 
                                                                                    
        local mouth = f.mouth
        local inset = f.radius + C.EdgeMargin + C.TargetSlack
        local half = mouth.halfWidth - inset
        if half <= 0 or mouth.top - inset <= mouth.bottom + f.radius then return nil end
        local x = (position - mouth.center):Dot(mouth.lateral)
        local _ns = mouth.lateral * (math.clamp(x, -half, half) - x)
            + _ip * math.min(0, mouth.top - inset - position.Y)
        local origin = f.sample.Origin + (f.aimOffset or _io)
        local distance = (origin - mouth.plane):Dot(mouth.forward)
        local _nt = (f.origin - mouth.plane):Dot(mouth.forward)
        local toward = -aim.Direction:Dot(mouth.forward)
        if distance <= 0 or _nt <= 0 or toward <= 1e-5 or _ns.Magnitude < 1e-5 then return nil end
        local direction = aim.Direction * (distance / toward) + _ns * (distance / _nt)
        if not _ir(direction) or direction.Magnitude < 1e-5 then return nil end
        local yaw, pitch = _kd(direction.Unit)
        return _kc(f, yaw, pitch)
    end
    local function _nu(mouth, target)
        local point = mouth.center + mouth.lateral * target.X
        return Vector3.new(point.X, target.Y, point.Z)
    end
    local function _nv(mouth, point)
        local x = (point - mouth.center):Dot(mouth.lateral)
        local height = (point.Y - mouth.bottom) / math.max(mouth.top - mouth.bottom, 0.01)
        local _nw = height < 1 / 3 and "LOW" or (height > 2 / 3 and "HIGH" or "MID")
                                                                
        local side = x > mouth.halfWidth / 3 and "LEFT" or (x < -mouth.halfWidth / 3 and "RIGHT" or "CENTER")
        return _nw .. " " .. side
    end
    local function _nx(f)
        local mouth = f.mouth
                                                                            
        local inset = f.radius + C.EdgeMargin + C.TargetSlack
        local half = mouth.halfWidth - inset
        local low = mouth.bottom + f.radius + 0.4
        local high = mouth.top - inset
        if half <= 0 or high <= low then return {} end
        local _ny = (low + high) / 2
        local targets = {}
                                                                                            
                                                                                            
        local speed = (N.Shoot.Constants.Shot and N.Shoot.Constants.Shot.MaximumSpeed) or 123
        for _nw, height in ipairs({ _ny, high, low }) do
            for _, x in ipairs({ -half, half, 0, -half * 0.5, half * 0.5 }) do
                local target = Vector2.new(x, height)
                local point = _nu(mouth, target)
                local eta = (point - f.origin).Magnitude / math.max(speed, 1)
                local _, difficulty = _lm(f, point, point, eta)
                local _nz = (difficulty - 1) * d.M.Dive.Constants.Distance - eta * 0.35 + _mv(mouth, point)
                local _, risk = _mi(f, f.origin, point, 0, eta)
                targets[#targets + 1] = { target = target, priority = _nz, order = #targets + 1, level = _nw, defenderRisk = risk }
            end
        end
        table.sort(targets, function(a, b)
            if a.defenderRisk ~= b.defenderRisk then return a.defenderRisk < b.defenderRisk end
            if a.priority == b.priority then return a.order < b.order end
            return a.priority > b.priority
        end)
                                                                                   
                                                                                   
                                                                                            
        local _oa, seen = {}, {}
        for _, entry in ipairs(targets) do
            if entry.level == 2 and math.abs(entry.target.X) == half then
                _oa[#_oa + 1] = entry
                seen[entry.level] = true
            end
        end
        for _, entry in ipairs(targets) do
            if not seen[entry.level] then seen[entry.level] = true; _oa[#_oa + 1] = entry end
        end
        for _, entry in ipairs(targets) do
            if not table.find(_oa, entry) then _oa[#_oa + 1] = entry end
        end
        return _oa
    end
    local function _ob(f, owner)
        owner.jobFrame = f
        owner.job = coroutine.create(function()
                                                                                                
                                                                                           
            local _oc = table.clone(f)
            _oc.charge = f.maximumCharge
            _oc.charges = { f.maximumCharge }
            local function _od(atPower, lane, aim)
                local _oe = false
                if aim then
                    local rating = _nj(atPower, aim, true)
                    stats.candidates += 1
                    owner.candidateEvaluations = (owner.candidateEvaluations or 0) + 1
                    if rating and _ii == owner and A.Enabled then
                        local _of = { direction = aim.Direction, frame = f, rating = rating,
                            at = os.clock(), lane = lane, power = atPower.charge, curve = atPower.curve }
                                                                                                     
                        for i = #owner.candidates, 1, -1 do
                            local previous = owner.candidates[i]
                            if previous.lane == _of.lane and previous.power == _of.power
                                and previous.curve == _of.curve then table.remove(owner.candidates, i) end
                        end
                        table.insert(owner.candidates, _of)
                        _oe = true
                        table.sort(owner.candidates, function(a, b) return _mr(a.rating, b.rating) end)
                        while #owner.candidates > 15 do table.remove(owner.candidates) end
                    end
                end
                coroutine.yield()
                return _oe
            end
            local targets = _nx(_oc)
                                                                                             
                                                                                           
                                                                                            
            local _og = {}
            local _, pitch = _kd(f.sample.Direction)
            for _, entry in ipairs(owner.rawRating and targets or {}) do
                local side = entry.target.X < 0 and -1 or (entry.target.X > 0 and 1 or 0)
                if side ~= 0 and (not _og[side] or math.abs(entry.target.X) > math.abs(_og[side].target.X)) then
                    _og[side] = entry
                end
            end
                                                                                  
            for _, side in ipairs({ -1, 1 }) do
                local entry = _og[side]
                if entry then
                    local direction = _nu(f.mouth, entry.target) - (f.sample.Origin + (f.aimOffset or _io))
                    local yaw = _kd(direction)
                    if _od(f, side == -1 and -1 or -2, _kc(f, yaw, pitch))
                        and f.charge <= f.minimumCharge + 0.025 then owner.tapPrepared = true end
                end
            end
            local function _oh(atPower, entry, seed)
                _od(atPower, entry.order, _kp(atPower, entry.target, seed))
            end
            local _oi = {}
            if not owner.tapPrepared and f.charge <= f.minimumCharge + 0.025 then
                local _oj = table.clone(f)
                _oj.charge, _oj.charges = f.minimumCharge, { f.minimumCharge }
                for _, entry in ipairs(targets) do
                    if entry.level == 3 then _oh(_oj, entry, {}); break end
                end
                owner.tapPrepared = true
            end
                                                                                   
                                                                                 
            for index = 1, math.min(2, #targets) do
                local entry = targets[index]
                local at = table.clone(_oc); at.curve = f.curve
                _oi[at.curve] = _oi[at.curve] or {}
                _oh(at, entry, _oi[at.curve])
            end
            if f.autoCurve then
                local curves, seenCurves = {}, { [f.curve] = true }
                for _, curve in ipairs({ -1, 1, 0 }) do
                    if not _ok[curve] then curves[#curves + 1] = curve; _ok[curve] = true end
                end
                for _, curve in ipairs(curves) do
                    for index = 1, math.min(2, #targets) do
                        local at = table.clone(_oc); at.curve = curve
                        _oi[curve] = _oi[curve] or {}
                        _oh(at, targets[index], _oi[curve])
                    end
                end
            end
                                                                                  
                                                                               
                                                                              
            local _ol
            if f.autoCurve then
                for _, entry in ipairs(targets) do
                    if entry.level == 1 then
                        local seen = {}
                        for _, curve in ipairs({ f.curve, -1, 1, 0 }) do
                            if not seen[curve] then
                                seen[curve] = true
                                local at = table.clone(_oc); at.curve = curve
                                _oi[curve] = _oi[curve] or {}
                                _oh(at, entry, _oi[curve])
                            end
                        end
                        _ol = entry
                        break
                    end
                end
            end
            for index, entry in ipairs(targets) do
                                                                                    
                                                                                      
                local curves = f.autoCurve and { f.curve, -1, 1, 0 } or { f.curve }
                local curve = curves[(index - 1) % #curves + 1]
                local candidateFrame = table.clone(_oc); candidateFrame.curve = curve
                _oi[curve] = _oi[curve] or {}
                if index > 2 and entry ~= _ol then _oh(candidateFrame, entry, _oi[curve]) end
            end
        end)
    end
    local function _om(f, owner)
        if _im then return end
        _im = true
        local began, calls = os.clock(), 0
        if not owner.job or coroutine.status(owner.job) == "dead" or not _nn(owner.jobFrame, f)
            or os.clock() - owner.jobFrame.clock > C.CandidateAge then _ob(f, owner) end
                                                                                 
                                                                                 
        local _oo = C.CallsPerSlice * 6
        while owner.job and coroutine.status(owner.job) ~= "dead" and _on < _oo do
            local ok, err = coroutine.resume(owner.job)
            if not ok then _im = false; error(err) end
            _on += 1
            if (os.clock() - began) * 1000 >= C.SliceMs then break end
        end
        stats.maxSliceMs = math.max(stats.maxSliceMs, (os.clock() - began) * 1000)
        _im = false
    end
    local function _op(owner)
        local distance = owner.distance and string.format("%.2f / %d studs", owner.distance, C.MaxAssistDistance) or ""
        if owner.reason == "out_of_range" then return "Out of range | " .. distance .. " | Normal aim" end
        if owner.reason == "waiting_volley" then return "Normal aim | Waiting for native volley timing" end
        if _iy[owner.reason] then return "Normal aim | " .. _iy[owner.reason] end
        local rating = owner.rating
        local count = owner.frame and #owner.frame.keepers or 0
        if not owner.frame then return "Normal aim | Keeper data unavailable" end
        if count == 0 then return "No keeper tracked | Reach unknown" end
        if rating and rating.gap ~= nil then
            local _oq = owner.autoCurve and (owner.frame.autoCurve
                and string.format(" | Curve %+.1f", owner.selectedCurve or owner.frame.curve)
                or " | Curve unavailable") or ""
            local defenders = owner.frame.defenders and #owner.frame.defenders or 0
            local coverage = defenders > 0 and string.format("%d GK / %d DEF", count, defenders) or string.format("%d GK tracked", count)
            return string.format("%s | %s\n%s | Estimated gap %.1f\n%d alternatives evaluated%s", distance,
                _nv(owner.frame.mouth, rating.position), coverage, rating.gap, owner.candidateEvaluations or 0, _oq)
        end
        return string.format("%s | %d GK tracked | Searching", distance, count)
    end
    local function _or(sample)
        local owner = _ii
        if not owner or owner.locked then return sample end
        owner.pair = nil
        owner.reason = nil
        owner.bestGap = nil
        owner.redirected = false
        owner.decisionAudit = nil
        owner.completedAlternatives, owner.checkedAlternatives = 0, 0
        local f = frame(sample)
        if not f then
            owner.applied, owner.rating, owner.frame, owner.job = false, nil, nil, nil
            owner.curveChoice = nil
            table.clear(owner.candidates)
            owner.reason = owner.reason or "ineligible"
            return sample
        end
        owner.sample = table.clone(sample)
        owner.frame = f
        if #f.keepers == 0 then
            owner.applied, owner.rating, owner.job, owner.reason = false, nil, nil, "no_keeper"
            owner.curveChoice = nil
            table.clear(owner.candidates)
            _it("NO GK DATA", "Normal aim | Keeper reach is unknown")
            return sample
        end
        local normal = _nj(f, sample, false)
        owner.rawRating = normal
        local _os = { scope = "current aim and freshly checked proposals", checked = {}, duplicatesSkipped = 0,
            rawScore = normal and normal.score, rawDefenderRisk = normal and normal.defenderRisk,
            rawCurve = f.curve, frameAt = f.clock, predictionCharge = f.charge }
        owner.decisionAudit = _os
        local clock = os.clock()
        if clock >= (owner.nextWork or 0) then
            owner.nextWork = clock + 1 / C.SampleHz
            _om(f, owner)
        end
        if not f.canApply then
            owner.applied, owner.rating, owner.reason = false, nil, "waiting_volley"
            _it("PREPARING VOLLEY", "Waiting for the native strike window | Normal aim")
            return sample
        end
        local best, _ot, _ou, _ov
        local choice = owner.curveChoice
        if choice and (not f.autoCurve or not _nn(choice.frame, f)) then
            owner.curveChoice, choice = nil, nil
        end
                                                                                     
                                                                               
                                                                               
                                                                                 
        local _ow = f.autoCurve and (#f.charges > 1 or owner.releasing or f.volley)
        local _ox = choice and choice.curve
        if _ow then _ox = nil end
        if f.autoCurve and not _ow and not choice then _ox = f.curve end
        do
            local _oy = f.volley and (f.canApply and "strike" or "prepare")
                or (#f.charges > 1 and "lock" or (owner.releasing and "release" or "early"))
            if owner.validationStage ~= _oy then
                owner.validationStage = _oy
                                                                                   
                                                                                  
                                                                                     
                for _, entry in ipairs(owner.candidates) do entry.checkedAt = nil end
            end
        end
                                                                                               
                                                                            
        local checked, seenAims = 0, {}
        local _pa = table.clone(owner.candidates)
                                                                                     
                                                                                           
        local incumbent = choice and choice.candidate or owner.selectedCandidate
        if incumbent then table.insert(_pa, 1, incumbent) end
        owner.validationPass = (owner.validationPass or 0) + 1
        local _pb = owner.validationPass % 2 == 0
        table.sort(_pa, function(a, b)
                                                                                        
                                                                                  
            local incumbent = choice and choice.candidate or owner.selectedCandidate
            if a == incumbent then return b ~= incumbent end
            if b == incumbent then return false end
                                                                                     
                                                                                  
            if _pb then
                local ar, br = a.rating, b.rating
                if a.checkedStage == owner.validationStage then ar = a.checkedRating end
                if b.checkedStage == owner.validationStage then br = b.checkedRating end
                if _mr(ar, br) then return true end
                if _mr(br, ar) then return false end
            end
            local _pc, bc = a.checkedAt or 0, b.checkedAt or 0
            if _pc ~= _pd then return _pc < _pd end
            local _pe = math.abs((a.power or f.charge) - f.charge)
            local _pf = math.abs((b.power or f.charge) - f.charge)
            if math.abs(_pe - _pf) > 1e-5 then return _pe < _pf end
            return _mr(a.rating, b.rating)
        end)
        for _, entry in ipairs(_pa) do
            if (_ox == nil or entry.curve == _ox)
                and _nn(entry.frame, f) and clock - entry.at <= C.CandidateAge then
                local aim = _no(entry, f)
                local candidateFrame = f
                if f.autoCurve and entry.curve ~= nil then
                    candidateFrame = table.clone(f); candidateFrame.curve = entry.curve
                end
                                                                                   
                                                                                
                                                                           
                local _pg
                for _, seen in ipairs(_oz) do
                                                                                 
                                                                                 
                    if (seen.direction - aim.Direction).Magnitude <= 1e-6 and seen.curve == candidateFrame.curve then
                        _pg = seen
                        break
                    end
                end
                if _pg then
                    entry.checkedAt = _pg.checkedAt
                    _os.duplicatesSkipped += 1
                    continue
                end
                checked += 1
                owner.validationSequence = (owner.validationSequence or 0) + 1
                entry.checkedAt = owner.validationSequence
                _oz[#_oz + 1] = { direction = aim.Direction, curve = candidateFrame.curve,
                    checkedAt = entry.checkedAt }
                local rating, edgePosition = _nj(candidateFrame, aim, false)
                local _ph = false
                if not rating and edgePosition and checked < 2 then
                    local corrected = _nr(candidateFrame, aim, edgePosition)
                    if corrected then
                        checked += 1
                        rating = _nj(candidateFrame, corrected, false)
                        if rating then
                            _ph = true
                            aim = corrected
                            entry.direction, entry.frame, entry.at = aim.Direction, f, clock
                            entry.rating, entry.power = rating, f.charge
                        end
                    end
                end
                _os.checked[#_os.checked + 1] = { valid = rating ~= nil, curve = candidateFrame.curve,
                    score = rating and rating.score, defenderRisk = rating and rating.defenderRisk,
                    gap = rating and rating.gap, flightSeconds = rating and rating.eta,
                    ageSeconds = math.max(0, os.clock() - entry.at), correctedEdge = _ph }
                                                                                 
                                                                              
                                                                                    
                entry.checkedStage, entry.checkedRating = owner.validationStage, rating
                if _mr(rating, best) then
                    _ot, best, _ou, selectedCurve = aim, rating, entry, candidateFrame.curve
                end
                if checked >= 2 then break end
            end
        end
                                                                                                   
                                                                                                            
        local _pi = normal and (_ox == nil or f.curve == _ox)
            and not _mr(best, normal)
        if _pi then _ot, best, _ou, selectedCurve = table.clone(sample), normal, nil, f.curve end
        if choice and not _ot then
                                                                                  
                                                                                   
            owner.curveChoice, choice = nil, nil
            if normal then _ot, best, _ou, selectedCurve = table.clone(sample), normal, nil, f.curve end
        end
        owner.selectedCandidate = _ou
        owner.completedAlternatives = #owner.candidates
        owner.checkedAlternatives = checked
        _os.proposalPool = #owner.candidates
        _os.requiredCurve = _ox
        _os.selectedScore = best and best.score
        _os.selectedDefenderRisk = best and best.defenderRisk
        _os.selectedCurve = _ov
        _os.confirmedOriginalAim = _pi == true
        if not _ot then
            owner.applied, owner.rating, owner.reason = false, nil, "searching"
            _it(#f.keepers == 0 and "SEARCHING / NO GK DATA" or "SEARCHING", _op(owner))
            return sample
        end
        owner.bestGap = best.gap
        owner.selectedCurve = _ov
        if f.autoCurve and (choice or _ow) then
            owner.curveChoice = { curve = _ov, frame = f,
                candidate = { direction = _ot.Direction, frame = f, at = clock,
                    power = f.charge, curve = _ov, rating = best } }
        end
        if f.autoCurve then
            owner.pair = { aim = _ot, direction = _ot.Direction, curve = _ov,
                manualCurve = f.curve, character = f.character, context = f.context, ballId = f.ballId }
        end
        owner.applied, owner.rating, owner.direction = true, best, _ot.Direction
        owner.appliedAim = table.clone(_ot)
        owner.redirected = (_ot.Direction - sample.Direction).Magnitude > 1e-5 or math.abs(_ov - f.curve) > 1e-5
        owner.reason = owner.redirected and "assisted" or "confirmed_aim"
        stats.lastCharge, stats.lastCurve = f.charge, _ov
        _it(best.defenderRisk == 2 and "DEFENDER IN SHOT PATH"
            or (best.defenderRisk == 1 and "DEFENDERS COVER SHOT")
            or (not owner.redirected and "AIM CONFIRMED" or (best.gap >= C.ClearGapThreshold and "OUTSIDE MODELED REACH" or "BEST AVAILABLE SHOT")),
            _op(owner))
        local scope = _ik[_is()]
        if scope then scope.applied = true end
        return _ot
    end
    local function observe(command, locked)
        if _ii and command and command.PassType == d.M.Actions.PassTypes.Shot then
            _ii.curve = command.Curve or 0
            if A.SmartRelease and _ii.smartRelease and typeof(command.AimDirection) == "table" then
                _ii.nativeAimRevision = (_ii.nativeAimRevision or 0) + 1
                _ii.nativeAim = table.clone(command.AimDirection)
                local root = d.Player.Character and d.Player.Character:FindFirstChild("HumanoidRootPart")
                _ii.nativeAimRoot = root and root.Position or nil
            end
            if locked then
                _ii.locked = true
                _ii.job = nil
                local count = _ii.frame and #_ii.frame.keepers or 0
                local _pj = not _ii.applied
                _it(_pj and "NATIVE AIM LOCKED" or (count == 0 and "AIM LOCKED / NO GK DATA" or "AIM LOCKED"), _op(_ii))
            end
        end
    end
    local function _pk(aim)
        local pair = _ii and _ii.pair
        if not (alive and A.Enabled and pair and typeof(aim) == "table") then return nil end
                                                                                 
                                                                              
        if aim.Direction ~= pair.direction or pair.character ~= d.Player.Character
            or pair.ballId ~= ballId() or pair.context ~= d.M.Motion.GetContext(pair.character)
            or not N.Curves.IsEnabled() then return nil end
        return pair.curve, pair
    end
    local function _pl(owner)
        if not owner.applied or not owner.frame or owner.input == nil or not _iq(owner.chargeStartedAt)
            or N.Client.IsVolleyCharging() or not ownsBall() then return nil end
        local sample = owner.nativeAim
        if typeof(sample) ~= "table" or not owner.appliedAim
            or sample.Direction ~= owner.appliedAim.Direction then return nil end
        sample = table.clone(sample)
        if owner.locked then
            local root = d.Player.Character and d.Player.Character:FindFirstChild("HumanoidRootPart")
            if not root or not _ir(owner.nativeAimRoot) then return nil end
            local delta = root.Position - owner.nativeAimRoot
            sample.Origin += delta
            sample.CameraCFrame += delta
        end
        local f = frame(sample, 0)
        if not f or #f.keepers == 0 or not _nn(owner.frame, f)
            or f.elapsed < f.minimumCharge + 0.005 or f.elapsed >= f.maximumCharge - 0.015 then return nil end
                                                                                    
        if f.autoCurve and not owner.curveChoice then return nil end
        local curve = f.curve
        if f.autoCurve then curve = _pk(sample) end
        if curve == nil then return nil end
        local function _pm(_gn)
            local at = _gn == 0 and f or frame(sample, _gn)
            if not at or not _nn(f, at) then return nil, false end
            at = table.clone(at)
            at.curve = curve
            return _nj(at, sample, false), true
        end
                                                                               
                                                                                 
                                                                                  
        local began = os.clock()
        local function _pn()
            if (os.clock() - began) * 1000 <= C.ReleaseBudgetMs then return true end
            stats.releaseBudgetSkips += 1
            owner.releaseTiming = { decision = "budget" }
            return false
        end
        stats.releaseChecks += 1
        local now = _pm(0)
        if not _pn() or not now then return nil end
        local remaining = f.maximumCharge - f.elapsed
        local _po
        for _, _gn in ipairs({ remaining / 2, remaining }) do
            local _pp, valid = _pm(_gn)
            if not _pn() or not _pq then return nil end
            if _mr(_pp, _po) then _po = _pp end
        end
        local _pr = not _po
            or ((now.defenderRisk or 0) ~= (_po.defenderRisk or 0) and _mr(now, _po))
            or ((now.defenderRisk or 0) == (_po.defenderRisk or 0) and now.score >= _po.score + C.ReleaseMargin)
        owner.releaseTiming = { decision = _pr and "release" or "wait", charge = f.charge,
            nowScore = now.score, laterScore = _po and _po.score or nil,
            nowDefenderRisk = now.defenderRisk, laterDefenderRisk = _po and _po.defenderRisk or nil }
        if _pr then return now end
        return nil
    end
    local function _ps()
        local owner = _ii
        if not (alive and A.Enabled and A.SmartRelease and owner and owner.smartRelease)
            or owner.releasing or owner.smartDispatched or not N.Client.IsCharging() then return end
        local clock = os.clock()
        if clock < (owner.nextReleaseCheck or 0) then return end
        owner.nextReleaseCheck = clock + C.ReleaseInterval
        local began = os.clock()
        local rating = _pl(owner)
        stats.maxReleaseMs = math.max(stats.maxReleaseMs, (os.clock() - began) * 1000)
        if not rating or _ii ~= owner or not (A.Enabled and A.SmartRelease and eligible())
            or not N.Client.IsCharging() or N.Client.IsVolleyCharging() or not ownsBall() then return end
                                                                                  
                                                                                  
        owner.smartDispatched = true
        owner.rating = rating
        stats.releaseRequests += 1
        N.Client.HandleInputEnded(owner.input)
    end
    local function _pt(command)
        if not command or command.PassType ~= d.M.Actions.PassTypes.Shot then return command end
        local curve = _pk(command.AimDirection)
        if curve == nil then return command end
        local result = table.clone(command)
        result.Curve = curve ~= 0 and curve or nil
        return result
    end
    local function _pu(_pv, source, outgoing, ...)
        if source == outgoing then return _pv(source, ...) end
        local result = table.pack(pcall(_pv, outgoing, ...))
                                                                              
                                                                                
        for key in pairs(source) do
            if key ~= "Curve" and outgoing[key] == nil then source[key] = nil end
        end
        for key, value in pairs(outgoing) do if key ~= "Curve" then source[key] = value end end
        if not result[1] then error(result[2], 0) end
        return table.unpack(result, 2, result.n)
    end
    local function hook(object, key, build)
        local _pv = object[key]
        assert(type(_pv) == "function", "Missing native function: " .. key)
        local _pw = build(_pv)
        object[key] = _pw
        table.insert(hooks, { object = object, key = key, original = _pv, wrapper = _pw })
    end
    local function _px()
        local _py = {}
        for i = #hooks, 1, -1 do
            local entry = hooks[i]
            local ok = pcall(function()
                if entry.object[entry.key] == entry.wrapper then entry.object[entry.key] = entry.original end
            end)
            if not ok then table.insert(_py, entry) end
        end
        hooks = _py
        return #_py == 0
    end
    local function _pz()
        local paths = { Client = "Client.Gameplay.Actions.Shoot", Reticle = "Client.Interface.Reticle",
            Preview = "Client.Gameplay.Actions.ChargePathPreview", Velocity = "Modules.Actions.ChargePathVelocity",
            Shoot = "Modules.Actions.Shoot", Core = "Modules.Actions.KickCore", Power = "Modules.Actions.KickPowerups",
            Carry = "Modules.Ball.Carry", Curves = "Modules.CurvedKicks", Tutorial = "Client.Gameplay.TutorialSession",
            ShotAssist = "Modules.Actions.ShotAimAssist", Follow = "Client.Gameplay.Visual.TrajectoryPreviewFollow",
            Controls = "Modules.Gameplay.Controls", Volley = "Client.Gameplay.Actions.VolleyOpportunity",
            Receiving = "Modules.Ball.Receiving", Tackle = "Modules.Actions.SlideTackle", ActionMovement = "Modules.Actions.ActionMovement" }
        for name, path in pairs(paths) do
            assert(alive and d.alive(), "STR was unloaded while dependencies were loading")
            N[name] = d.load(path)
        end
        assert(alive and d.alive(), "STR was unloaded while dependencies were loading")
        N.RawLaunch, N.RawSpin = N.Velocity.GetLaunchVelocity, N.Shoot.GetSpin
        assert(type(N.RawLaunch) == "function" and type(N.RawSpin) == "function", "Native shot prediction is unavailable")
        hook(N.Velocity, "GetLaunchVelocity", function(_pv) return function(...)
            if not (_ii and _ii.pair) then return _pv(...) end
            local args = table.pack(...)
            local key = _is()
            _il[key] = nil
            local curve, pair
            if args[1] == d.Player.Character and args[3] == d.M.Actions.PassTypes.Shot then
                curve, pair = _pk(args[4])
            end
            if curve == nil then return _pv(table.unpack(args, 1, args.n)) end
            args[12], args.n = curve, math.max(args.n, 12)
            local result = table.pack(_pv(table.unpack(args, 1, args.n)))
            if _ir(result[1]) then _il[key] = { pair = pair, velocity = result[1], character = args[1] } end
            return table.unpack(result, 1, result.n)
        end end)
        hook(N.Shoot, "GetSpin", function(_pv) return function(character, velocity, playerVelocity, curve, _jt)
            local _qa = _il[_is()]
            if _qa and character == _qa.character and velocity == _qa.velocity
                and _ii and _ii.pair == _qa.pair then
                local selected = _pk(_qa.pair.aim)
                if selected ~= nil then curve = selected end
            end
            return _pv(character, velocity, playerVelocity, curve, _jt)
        end end)
        if type(N.Client.SetOwnerUserId) == "function" then
            hook(N.Client, "SetOwnerUserId", function(_pv) return function(_sc, ...)
                local result = table.pack(_pv(_sc, ...))
                if alive then
                    _ij = nil
                    _iw(function()
                        local ch = d.Player.Character
                        _ij = ch and { userId = _sc, character = ch, ballId = ballId(),
                            context = d.M.Motion.GetContext(ch) } or nil
                    end)
                end
                return table.unpack(result, 1, result.n)
            end end)
        end
        hook(N.Client, "HandleInputBegan", function(_pv) return function(_sl, processed, transfer)
            if not alive or not A.Enabled then return _pv(_sl, processed, transfer) end
            if not processed and N.Controls.IsInput("Kick", _sl) and not N.Client.IsCharging() then
                _ii = { started = os.clock(), curve = 0, candidates = {}, locked = false, autoCurve = A.AutoCurve,
                    input = _sl, smartRelease = A.SmartRelease,
                    volleyArrival = transfer and transfer.VolleyArrivalTime or nil }
            end
            local result = table.pack(_ix(_pv, _sl, processed, transfer))
            if not N.Client.IsCharging() then _ii = nil end
            return table.unpack(result, 1, result.n)
        end end)
        hook(N.Volley, "GetPredictedArrivalTime", function(_pv) return function(...)
            local result = table.pack(_pv(...))
            if alive and A.Enabled and _ii and _ik[_is()] and _iq(result[1]) then
                _ii.volleyArrival = result[1]
            end
            return table.unpack(result, 1, result.n)
        end end)
        hook(N.Volley, "PredictLock", function(_pv) return function(_sc, arrival, ...)
            local result = table.pack(_pv(_sc, arrival, ...))
            if alive and A.Enabled and _ii and _sc == d.Player.UserId and _iq(arrival) then
                _ii.volleyArrival, _ii.volleyRefused = arrival, false
            end
            return table.unpack(result, 1, result.n)
        end end)
        if type(N.Client.HandleVolleyRefused) == "function" then
            hook(N.Client, "HandleVolleyRefused", function(_pv) return function(...)
                if alive and A.Enabled and _ii then
                    _ii.volleyArrival, _ii.volleyRefused, _ii.job = nil, true, nil
                    table.clear(_ii.candidates)
                end
                return _pv(...)
            end end)
        end
        for _, key in ipairs({ "UpdateAim", "UpdateChargePath" }) do
            hook(N.Client, key, function(_pv) return function(...)
                if key ~= "UpdateAim" or not (A.SmartRelease and _ii and _ii.smartRelease)
                    or _ii.releasing or _ii.smartDispatched then return _ix(_pv, ...) end
                local owner = _ii
                local _qb = owner and owner.nativeAimRevision
                local result = table.pack(_ix(_pv, ...))
                                                                                     
                                                                                      
                if key == "UpdateAim" and owner and _ii == owner and owner.nativeAimRevision ~= _qb
                    and not _ik[_is()] and alive and A.Enabled and A.SmartRelease then
                    _iw(_ps)
                end
                return table.unpack(result, 1, result.n)
            end end)
        end
        hook(N.Client, "HandleInputEnded", function(_pv) return function(_sl)
            if alive and A.Enabled and _ii and N.Controls.IsInput("Kick", _sl) then
                _ii.releasing = true
                if not _ii.locked and not _ii.smartDispatched then _ix(N.Client.UpdateAim) end
            end
            return _ix(_pv, _sl)
        end end)
        hook(N.Reticle, "GetCameraAimRayWithoutHit", function(_pv) return function(...)
            local sample = _pv(...)
            if not alive or not A.Enabled or not _ik[_is()] then return sample end
            local scope = _ik[_is()]
            scope.source = sample
            scope.applied = false
            local began = os.clock()
            local result = _iw(_or, sample) or sample
            stats.maxAimMs = math.max(stats.maxAimMs, (os.clock() - began) * 1000)
            return result
        end end)
        hook(N.Velocity, "Get", function(_pv) return function(...)
            if not alive or not A.Enabled or not _ik[_is()] then return _pv(...) end
            local args = table.pack(...)
            local scope = _ik[_is()]
            if alive and A.Enabled and scope and _ii
                and args[1] == d.Player.Character and args[3] == d.M.Actions.PassTypes.Shot then
                local curve = args[10] or 0
                if math.abs(curve - (_ii.curve or 0)) > 1e-5 then
                    _ii.curve = curve
                    _ii.job = nil
                    _ii.pair = nil
                                                                                                       
                    if scope.applied and scope.source and typeof(args[4]) == "table" then
                        args[4].Direction = scope.source.Direction
                        scope.applied, _ii.applied, _ii.rating = false, false, nil
                    end
                end
            end
            return _pv(table.unpack(args, 1, args.n))
        end end)
                                                                                   
                                                                                              
        hook(N.ShotAssist, "GetAssistedDirection", function(_pv) return function(...)
            local scope = _ik[_is()]
            if alive and A.Enabled and scope and scope.applied then return nil, nil end
            return _pv(...)
        end end)
        hook(N.Follow, "StepAimSampleCFrame", function(_pv) return function(...)
            local scope = _ik[_is()]
            if alive and A.Enabled and scope and scope.applied then return CFrame.identity end
            return _pv(...)
        end end)
        hook(d.M.Protocol, "Start", function(_pv) return function(command)
            if alive and A.Enabled then
                _iw(observe, command, false)
                if _ii and command and command.PassType == d.M.Actions.PassTypes.Shot then
                    _ii.chargeStartedAt = command.ShotTime
                end
            end
            return _pu(_pv, command, _pt(command))
        end end)
        hook(d.M.Protocol, "Update", function(_pv) return function(command)
            if alive and A.Enabled then _iw(observe, command, false) end
            return _pu(_pv, command, _pt(command))
        end end)
        hook(d.M.Protocol, "LockAim", function(_pv) return function(command, at)
            if alive and A.Enabled then _iw(observe, command, true) end
            return _pu(_pv, command, _pt(command), at)
        end end)
        hook(d.M.Protocol, "Release", function(_pv) return function(command)
            local source = command
            local _qc, _qd, _qe
            command = _pt(command)
            if alive and A.Enabled and _ii and command.PassType == d.M.Actions.PassTypes.Shot then
                stats.shots += 1
                if _ii.smartDispatched then stats.autoReleases += 1 end
                if _ii.applied then stats.assisted += 1 end
                if _ii.applied and _ii.redirected then stats.redirected += 1 end
                if _ii.applied and not _ii.redirected then stats.confirmed += 1 end
                stats.lastCharge, stats.lastCurve = command.ChargeSeconds or 0, command.Curve or 0
                table.insert(_ih, { charge = stats.lastCharge, curve = stats.lastCurve,
                    assisted = _ii.applied == true, aimLocked = _ii.locked == true,
                    redirected = _ii.applied == true and _ii.redirected == true,
                    decision = _ii.reason or "native", bestCandidateGap = _ii.bestGap,
                    completedAlternatives = _ii.completedAlternatives or 0,
                    checkedAlternatives = _ii.checkedAlternatives or 0,
                    evaluatedAlternatives = _ii.candidateEvaluations or 0,
                    autoCurve = _ii.autoCurve == true,
                    smartReleased = _ii.smartDispatched == true,
                    releaseTiming = _ii.releaseTiming,
                    curveChanged = _ii.pair ~= nil and math.abs(_ii.pair.curve - _ii.pair.manualCurve) > 1e-5,
                    distance = _ii.distance, shotKind = _ii.volley and "volley" or "owned",
                    team = _ii.frame and _ii.frame.team or nil,
                    context = _ii.frame and _ii.frame.context or nil,
                    ballId = _ii.frame and _ii.frame.ballId or nil,
                    volleyRemaining = _ii.frame and _ii.frame.arrivalRemaining or nil,
                    estimatedGap = _ii.rating and _ii.rating.gap or nil,
                    reachDemand = _ii.rating and _ii.rating.reachDemand or nil,
                    estimatedKeeperDifficulty = _ii.rating and _ii.rating.difficulty or nil,
                    predictionCharge = _ii.rating and _ii.rating.predictionCharge or nil,
                    estimatedFlightSeconds = _ii.rating and _ii.rating.eta or nil,
                    estimatedEdgeClearance = _ii.rating and _ii.rating.edgeClearance or nil,
                    trackedDefenders = _ii.frame and _ii.frame.defenders and #_ii.frame.defenders or 0,
                    defenderDemand = _ii.rating and _ii.rating.defenderDemand or nil,
                    defenderRisk = _ii.rating and _ii.rating.defenderRisk or nil,
                    targetZone = _ii.rating and _ii.frame and _nv(_ii.frame.mouth, _ii.rating.position) or nil,
                    outsideModeledReach = _ii.rating ~= nil and _ii.rating.gap ~= nil
                        and _ii.rating.gap >= C.ClearGapThreshold and (_ii.rating.defenderRisk or 0) == 0,
                    trackedKeepers = _ii.frame and #_ii.frame.keepers or 0 })
                _qc, evaluationFrame = _ih[#_ih], _ii.frame
                _qc.selectionAudit = _ii.decisionAudit
                _qc.predictionAgeSeconds = _ii.frame and math.max(0, os.clock() - _ii.frame.clock) or nil
                _qe = _ii.rating and _ii.rating.position
                if #_ih > 12 then table.remove(_ih, 1) end
                local _qf = _ii.smartDispatched and "smart release | "
                    or (_ii.applied and (_ii.redirected and "assisted | " or "aim confirmed | ") or "normal | ")
                _it("READY", "Last shot: " .. _qf .. _op(_ii))
                _ii.job = nil
                _ii = nil
                table.clear(_il)
            end
            local result = table.pack(_pu(_pv, source, command))
            if d.evaluation and _qc then
                d.evaluation.Call("ShotSent", _qc, _qd, command, _qe)
            end
            return table.unpack(result, 1, result.n)
        end end)
        for _, key in ipairs({ "HandleStartRejected", "HandleReleaseRejected" }) do
            if type(N.Client[key]) == "function" then
                hook(N.Client, key, function(_pv) return function(...)
                    if alive and A.Enabled then stats.rejected += 1 end
                    return _pv(...)
                end end)
            end
        end
        hook(N.Client, "CancelCharge", function(_pv) return function(...)
            local result = table.pack(_pv(...))
            if alive and A.Enabled then
                _ii = nil
                table.clear(_il)
                _it("READY", "Charge canceled. Shoot normally.")
            end
            return table.unpack(result, 1, result.n)
        end end)
        hook(N.Client, "Cleanup", function(_pv) return function(...)
            _ii, ownerSnapshot = nil, nil
            table.clear(_il)
            if alive and A.Enabled then _it("READY", "Shoot normally. Hold for charge.") end
            return _pv(...)
        end end)
        A.Ready = true
    end
    local function _qg()
        local pair = _ii and _ii.pair
        if pair and math.abs(pair.curve - pair.manualCurve) > 1e-5 and N.Client.IsCharging() then
                                                                                    
                                                                                   
            local ok, err = pcall(N.Client.CancelCharge)
            if not ok then A.LastError = tostring(err); return false end
        end
        return true
    end
    function A.SetEnabled(value)
        if not alive or _in then return false end
        if value and A.Enabled then return true end
        if not value and not _qg() then return false end
        if value and not A.Ready then
            _in = true
            local ok, err = pcall(_pz)
            _in = false
            if not ok then _px(); _iu(err); return false end
        end
        A.Enabled = value == true
        if A.Enabled then A.LastError = nil end
        _ii = nil
        _it(A.Enabled and "READY" or "OFF", A.Enabled and "Shoot normally. Hold for charge." or "")
        return true
    end
    function A.SetAutoCurve(value)
        if not alive or _in then return false end
        if (value == true) == A.AutoCurve and (not value or A.Enabled) then return true end
        if not value and not _qg() then return false end
        A.AutoCurve = value == true
        if A.AutoCurve and not A.Enabled and not A.SetEnabled(true) then return false end
        if _ii and not _ii.locked then
            _ii.autoCurve, _ii.job = A.AutoCurve, nil
            _ii.curveChoice = nil
            table.clear(_ii.candidates)
        end
        return true
    end
    function A.SetSmartRelease(value)
        if not alive or _in then return false end
        if value and not A.Enabled and not A.SetEnabled(true) then return false end
        A.SmartRelease = value == true
                                                                                    
        if _ii and not A.SmartRelease then _ii.smartRelease = false end
        return true
    end
    function A.Cleanup()
        if not _qg() then return false end
        alive, A.Enabled = false, false
        _ii, ownerSnapshot = nil, nil
        table.clear(_il)
        _it("OFF", "")
        return _px()
    end
    function A.Debug()
        return { enabled = A.Enabled, autoCurve = A.AutoCurve, smartRelease = A.SmartRelease, ready = A.Ready, status = A.Status, detail = A.Detail,
            lastError = A.LastError, stats = table.clone(stats), active = _ii ~= nil,
            locked = _ii and _ii.locked or false, recentShots = table.clone(_ih), prototype = "STR 0.16",
            defenderAwareness = true,
            releaseTiming = _ii and _ii.releaseTiming or nil,
            maxAssistDistance = C.MaxAssistDistance, clearGapThreshold = C.ClearGapThreshold }
    end
    if d.test then A.Test = { mouthFor = _jd, mouthDistance = _je, keeperGap = _la,
        reachDemand = _lm, validate = _mw, defenderDemand = _mi, defenderProfile = _lr,
        betterRating = _mr,
        solve = _kp, frame = frame, scopeCall = _ix, choose = _or, native = N,
        compatible = _nn, launch = _ke, rate = _nj, stats = stats, keepersFor = _jn, candidateAim = _no,
        horizontalReach = _ky, searchTargets = _nx, shotZone = _nv,
        setSession = function(value) _ii = value end, getSession = function() return _ii end } end
    return A
end

                                                                                        
local function _qh(d)
    local A = { AutoDribble = false, InfiniteStamina = false, DribbleStatus = "OFF", StaminaStatus = "OFF" }
    local N: { [string]: any } = {}
    local alive, _qi, loadingStamina = true, false, false
    local _qk, staminaGeneration = 0, 0
    local heartbeat, inputConnection = nil, nil
    local _qn, nativeOwner = nil, nil
    local _qp, _qq, correctionPending = nil, nil, nil
    local _qs = nil
    local _qt = 0
    local nextTick, _qu, _qv, retryAt = 0, 0, 0, 0
    local candidates, cachedCharacter = {}, nil
    local _qy = "DmcStamina_" .. d.id
    local _qz = false
    local stats = { scans = 0, threats = 0, proximityTriggers = 0, tackleTriggers = 0, kickTriggers = 0,
        attempts = 0, started = 0, nativeBlocked = 0, localCorrections = 0,
        staminaAutoOff = 0, positionRepairs = 0, staminaBudgetResets = 0,
        observerErrors = 0, errors = 0, maxTickMs = 0 }
    local _ra = {}
    local _rb = nil
    local C = { Interval = 1 / 30, DiscoverySeconds = 0.15, Range = 40, Lookahead = 0.22, KickLookahead = 0.12,
        RetrySeconds = 0.25, Step = 0.025, Padding = 1.0, ManualGrace = 0.15 }
    local function flat(v) return Vector3.new(v.X, 0, v.Z) end
    local function finite(n) return type(n) == "number" and n == n and math.abs(n) < math.huge end
    local function vector(v) return typeof(v) == "Vector3" and finite(v.X) and finite(v.Y) and finite(v.Z) end
    local function _rc(err)
        A.LastError = tostring(err)
        stats.errors += 1
        warn("[Dmc Misc] " .. A.LastError)
    end
    local function _rd()
        if heartbeat then heartbeat:Disconnect(); heartbeat = nil end
        if _qm then _qm:Disconnect(); _qm = nil end
        if _qn then
            _qn.active = false
            if d.M.Dodge.SetOwnerUserId == _qn.wrapper then
                d.M.Dodge.SetOwnerUserId = _qn.original
            end
            _qn = nil
        end
        _qo = nil
        candidates, cachedCharacter = {}, nil
        _qu = 0
    end
    local function _re()
        if _qp then _qp:Disconnect(); _qp = nil end
        if _qq then
            _qq.active = false
                                                                                          
            if N.Guard.Validate == _qq.observer then N.Guard.Validate = _qq.original end
            _qq = nil
        end
        if _qs then
            _qs.active = false
            if N.Placement.RepairPosition == _qs.observer then
                N.Placement.RepairPosition = _qs.original
            end
            _qs = nil
        end
        _qr = nil
    end
    local function _rf(correction)
        _rb = correction
        if not _qr then _qr = correction end
        A.StaminaStatus = "CORRECTION DETECTED"
    end
    local function _rg()
        local hook = { original = N.Placement.RepairPosition, active = true }
        local function _rh(character, root, target)
            if not (hook.active and alive and d.alive() and A.InfiniteStamina)
                or character ~= d.Player.Character or not root or not vector(target)
                or d.M.Replay.IsActive() or d.M.Freeze.IsFrozen() then return nil end
            return { position = root.Position, velocity = root.AssemblyLinearVelocity,
                context = d.M.Motion.GetContext(character) }
        end
        local function observe(sample, target, result)
            if not sample or result[2] ~= true then return end
            local origin = vector(result[1]) and result[1] or sample.position
            local delta = target - origin
            local horizontal = flat(delta)
            if horizontal.Magnitude <= 0.5 then return end
            local velocity = flat(sample.velocity)
                                                                                       
                                                                                       
            if velocity.Magnitude >= 1 and horizontal:Dot(velocity.Unit) >= -0.5 then return end
            stats.positionRepairs += 1
            _rf({ clock = os.clock(), context = sample.context, positionChange = delta.Magnitude,
                horizontalChange = horizontal.Magnitude, source = "CharacterPlacement.RepairPosition",
                staminaWasOn = true, serverConfirmed = false, offStatus = "OFF: POSITION REPAIR" })
        end
        hook.observer = function(character, root, target, ...)
            local _ri, sample = pcall(_rh, character, root, target)
            if not _ri then stats.observerErrors += 1; sample = nil end
                                                                                        
            local result = table.pack(hook.original(character, root, target, ...))
            if sample then
                local ok = pcall(observe, sample, target, result)
                if not ok then stats.observerErrors += 1 end
            end
            return table.unpack(result, 1, result.n)
        end
        _qs = hook
        N.Placement.RepairPosition = hook.observer
    end
    local function _rj(correction)
                                                                                                  
        if _qz then
            N.Sprint.SetUnlimitedStamina(_qy, false)
            _qz = false
        end
        A.InfiniteStamina = false
        if not correction.budgetReset then
            local before = N.Sprint.GetStamina()
            local _rk = N.StaminaRules.GetStaminaMultiplier()
            assert(finite(before) and finite(_rk), "Native stamina recovery data unavailable")
            if before > 0 then
                                                                                               
                                                                                                 
                                                                                               
                N.Sprint.SpendStamina(before * math.max(1, _rk), true)
            end
            local _rl = N.Sprint.GetStamina()
            correction.staminaBeforeReset, correction.staminaAfterReset = before, _rl
            correction.budgetReset = true
            if finite(_rl) and _rl < before then stats.staminaBudgetResets += 1 end
        end
        return A.SetInfiniteStamina(false)
    end
    local function _rm()
        assert(type(N.Guard.Validate) == "function", "Movement correction observer unavailable")
        assert(type(N.Placement.RepairPosition) == "function", "Position repair observer unavailable")
        if _qq then
            assert(_qq.active, "Previous movement observer cleanup is incomplete")
            return
        end
        local hook = { original = N.Guard.Validate, active = true }
        local function _rn(root, _rp, _rq)
            stats.localCorrections += 1
            local correction = { clock = os.clock(), context = d.M.Motion.GetContext(d.Player.Character),
                positionChange = (root.Position - _rp).Magnitude,
                velocityChange = (root.AssemblyLinearVelocity - _rq).Magnitude,
                source = "LocalMovementGuard.Validate", staminaWasOn = true }
            _rf(correction)
        end
        hook.observer = function(root, ...)
            local character = d.Player.Character
            local _ro = hook.active and alive and d.alive() and A.InfiniteStamina
                and root ~= nil and character and root == character:FindFirstChild("HumanoidRootPart")
            local _rp = _ro and root.Position or nil
            local _rq = _ro and root.AssemblyLinearVelocity or nil
                                                                                           
            local result = hook.original(root, ...)
            if _ro and result == false then
                local ok = pcall(_rn, root, _rp, _rq)
                if not ok then
                    stats.observerErrors += 1
                    _qr = _qr or { source = "LocalMovementGuard.Validate", detail = "diagnostic unavailable" }
                end
            end
            return result
        end
        _qq = hook
        N.Guard.Validate = hook.observer
        _rg()
        _qp = d.Run.Heartbeat:Connect(function()
            if not (alive and d.alive() and _qr) or os.clock() < _qt then return end
            _qt = os.clock() + 1
                                                                                      
            local correction = _qr
            local ok, stopped = pcall(_rj, correction)
            if ok and stopped then
                stats.staminaAutoOff += 1
                _rb = correction
                A.StaminaStatus = correction.offStatus or "OFF: LOCAL CORRECTION"
            else
                                                                                        
                _qr = correction
                A.StaminaStatus = "CLEANUP REQUIRED"
                if not ok then stats.observerErrors += 1 end
            end
        end)
    end
    local function _rr(err)
        A.AutoDribble = false
        _qk += 1
        _rd()
        A.DribbleStatus = "ERROR"
        _rc(err)
    end
    local function _rs()
        local paths = { Controls = "Modules.Gameplay.Controls", Input = "Libraries.Input",
            Tackle = "Modules.Actions.SlideTackle", Sprint = "Client.Gameplay.Player.Sprint",
            Shoot = "Client.Gameplay.Actions.Shoot", ChargeState = "Modules.Actions.ActionChargeState",
            Effects = "Client.Gameplay.Actions.TackleEffects", KickCore = "Modules.Actions.KickCore",
            Power = "Modules.Actions.KickPowerups" }
        for name, path in pairs(paths) do
            if not N[name] then N[name] = d.load(path) end
        end
        for _, _um in ipairs({ { N.Controls, "CreateInput" }, { N.Controls, "IsInput" },
            { N.Controls, "IsAvailable" }, { N.Controls, "IsOnCooldown" }, { N.Controls, "IsActive" },
            { N.Input, "ShouldIgnoreKeybind" }, { N.Tackle, "GetSlidingUntil" },
            { N.Tackle, "GetMaximumTravelBetween" }, { N.Sprint, "CanSpendStamina" },
            { N.Shoot, "IsCharging" }, { N.ChargeState, "IsCharging" }, { N.Effects, "GetObservedChargeFill" },
            { N.KickCore, "GetMinimumReleaseDelaySeconds" }, { N.Power, "GetChargeConstants" },
            { d.M.Dodge, "HandleInputBegan" }, { d.M.Dodge, "IsDribbling" } }) do
            assert(type(_um[1][_um[2]]) == "function", "Missing native dribble API: " .. _um[2])
        end
        N.Dodge = N.Dodge or d.load("Modules.Actions.Dodge")
        assert(finite(N.Dodge.Constants.StaminaCost), "Missing dribble stamina cost")
        local box = d.M.Hitboxes.Kick
        assert(box and vector(box.Size) and typeof(box.CFrameOffset) == "CFrame", "Missing native kick hitbox")
    end
    local function _rt()
        return type(d.M.Renderer.GetMatchBallId) == "function" and d.M.Renderer.GetMatchBallId() or nil
    end
    local function _ru()
        local hook = { original = d.M.Dodge.SetOwnerUserId, active = true }
        assert(type(hook.original) == "function", "Native dribble ownership unavailable")
        hook.wrapper = function(_sc, ...)
            if hook.active then _qo = nil end
            local result = table.pack(hook.original(_sc, ...))
            if hook.active and alive and A.AutoDribble and d.alive() then
                local ok = pcall(function()
                    local ch = d.Player.Character
                    _qo = ch and { character = ch, ballId = _rt(),
                        context = d.M.Motion.GetContext(ch), userId = _sc } or nil
                end)
                if not ok then _qo = nil; stats.observerErrors += 1 end
            end
            return table.unpack(result, 1, result.n)
        end
        _qn = hook
        d.M.Dodge.SetOwnerUserId = hook.wrapper
    end
    local function ownsBall(ch)
                                                                                    
        if _qo and _qo.character == ch and _qo.ballId == _rt()
            and _qo.context == d.M.Motion.GetContext(ch) then
            return _qo.userId == d.Player.UserId
        end
        return d.M.Renderer.GetOwnedUserId() == d.Player.UserId
    end
    local function eligible()
        if not (alive and A.AutoDribble and d.alive()) then return nil, "OFF" end
        if d.suspended() or N.Input.ShouldIgnoreKeybind(false) or d.Gui.MenuIsOpen
            or os.clock() < _qv then return nil, "PAUSED" end
        local ch = d.Player.Character
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        local root = ch and ch:FindFirstChild("HumanoidRootPart")
        if not ch or not ch.Parent or not root or not hum or hum.Health <= 0 then return nil, "WAITING" end
        if d.M.Match.IsGoalkeeperCharacter(ch) then return nil, "GK ROLE" end
        if d.M.Freeze.IsFrozen() or d.M.Replay.IsActive() or d.M.Controllers.IsSuspended(ch) then return nil, "PAUSED" end
        if not ownsBall(ch) then return nil, "NO BALL" end
        if N.Shoot.IsCharging() then return nil, "SHOOTING" end
        for _, name in ipairs({ "Kick", "Pass", "Lob", "RainbowFlick" }) do
            if N.Controls.IsActive(name) then return nil, "STRIKING" end
        end
        if d.M.Dodge.IsDribbling() then return nil, "DRIBBLING" end
        if d.M.Slide.IsSlideTackling() or not d.M.Controllers.IsLanded(ch, hum) then return nil, "MOVING" end
        if not N.Controls.IsAvailable("Dribble") or N.Controls.IsOnCooldown("Dribble") then return nil, "COOLDOWN / BLOCKED" end
        if not N.Sprint.CanSpendStamina(N.Dodge.Constants.StaminaCost, true) then return nil, "LOW STAMINA" end
        if os.clock() < _qw then return nil, "RETRY WAIT" end
        return ch, root
    end
    local function _rv(ch)
        local seen, list = {}, {}
        local function add(character, actor)
            if not character or character == ch or seen[character] then return end
            seen[character] = true
            list[#list + 1] = { character = character, actor = actor or character }
        end
        for _, _j in ipairs(d.Players:GetPlayers()) do add(_j.Character, _j) end
        local folder = workspace:FindFirstChild("Characters")
        local function _rw(container)
            if not container then return end
            for _, child in ipairs(container:GetChildren()) do
                if child:IsA("Model") then add(child) end
            end
        end
        _rw(folder)
        _rw(folder and folder:FindFirstChild("NPCs"))
        candidates, cachedCharacter = list, ch
        _qu = os.clock() + C.DiscoverySeconds
    end
    local function _rx(a, b, half)
        local low, high = 0, 1
        for _, axis in ipairs({ "X", "Y", "Z" }) do
            local origin: number = a[axis]
            local delta: number = b[axis] - origin
            local extent: number = half[axis]
            if math.abs(delta) < 1e-8 then
                if math.abs(origin) > extent then return false end
            else
                local _ry, leave = (-extent - origin) / delta, (extent - origin) / delta
                if _ry > _rz then _ry, leave = _rz, _ry end
                low, high = math.max(low, _ry), math.min(high, _rz)
                if low > high then return false end
            end
        end
        return true
    end
    local function contactTime(ownCF, ownVelocity, otherCF, _sj, age)
        local constants = N.Tackle.Constants
        local first = math.max(0, constants.HitboxDelaySeconds - age)
        local last = math.min(C.Lookahead, constants.HitboxDelaySeconds + constants.HitboxSeconds - age)
        if last < first then return nil end
        local direction = flat(_sj)
        if direction.Magnitude < 1 then direction = flat(otherCF.LookVector) end
        if direction.Magnitude < 1e-5 then return nil end
        direction = direction.Unit
                                                                                    
                                                                                       
        local box = d.M.Hitboxes.SlideTackle
        local half = box.Size * 0.5 + Vector3.new(C.Padding, C.Padding, C.Padding)
        local _sa = CFrame.lookAt(otherCF.Position, otherCF.Position + direction)
        local function point(t)
            local travel = N.Tackle.GetMaximumTravelBetween(age, age + t,
                constants.StartupDashDistance, constants.Distance)
            local rootCF = _sa + direction * travel
            return (rootCF * box.CFrameOffset):PointToObjectSpace(ownCF.Position + ownVelocity * t)
        end
        local previous = point(first)
        if _rx(previous, previous, half) then return first end
        local steps = math.max(1, math.ceil((last - first) / C.Step))
        for i = 1, steps do
            local t = first + (last - first) * i / steps
            local current = point(t)
            if _rx(previous, current, half) then return t end
            previous = current
        end
        return nil
    end
    local function _sb(_of)
        local other, actor = _of.character, _of.actor
        if actor == other then
            local _sc = other:GetAttribute("UserId")
            actor = finite(_sc) and d.M.Actors.GetByUserId(_sc) or nil
        end
        if not actor or actor.Character ~= other or not finite(actor.UserId)
            or d.M.Match.IsGoalkeeperCharacter(other) or not N.ChargeState.IsCharging(actor) then return nil end
                                                                                                  
                                                                      
        local _sd, compact = N.Effects.GetObservedChargeFill(actor.UserId)
        if not finite(_sd) or _sd < 0 or _sd > 1 or _se ~= false then return nil end
        local constants = N.Power.GetChargeConstants(actor, N.KickCore.Constants)
        local maximum = constants and constants.MaximumChargeSeconds
        if not finite(maximum) or maximum <= 0 then return nil end
        local first = N.KickCore.GetMinimumReleaseDelaySeconds(_sd * maximum, constants)
        if not finite(first) or first < 0 or first > C.KickLookahead then return nil end
        return { first = first, fill = _sd }
    end
    local function _sf(ownCF, ownVelocity, otherCF, _sj, first)
        local box = d.M.Hitboxes.Kick
        local half = box.Size * 0.5 + Vector3.new(C.Padding, C.Padding, C.Padding)
                                                                                     
                                                                                       
        local function point(t)
            local rootCF = otherCF + _sj * t
            return (rootCF * box.CFrameOffset):PointToObjectSpace(ownCF.Position + ownVelocity * t)
        end
        local previous = point(first)
        if _rx(previous, previous, half) then return first end
        local steps = math.max(1, math.ceil((C.KickLookahead - first) / C.Step))
        for i = 1, steps do
            local t = first + (C.KickLookahead - first) * i / steps
            local current = point(t)
            if _rx(previous, current, half) then return t end
            previous = current
        end
        return nil
    end
    local function tick()
        local ch, rootOrReason = eligible()
        if not ch then A.DribbleStatus = rootOrReason; return end
        local root = rootOrReason
        local team = d.M.Teams.GetActorTeamName(d.Player)
                                                                                 
        local opposing = d.M.Match.Constants.TeamDisplayNames[team] and d.M.Match.GetOpposingTeamName(team)
        if not opposing then A.DribbleStatus = "WAITING FOR OPPONENT"; return end
        local context = d.M.Motion.GetContext(ch)
        local ownCF = d.M.Motion.GetCFrame(ch) or root.CFrame
        local velocity = d.M.Motion.GetVelocity(ch) or root.AssemblyLinearVelocity
        if not vector(ownCF.Position) or not vector(velocity) then return end
        if _qx ~= ch or os.clock() >= _qu then _rv(ch) end
        stats.scans += 1
        A.DribbleStatus = "WATCHING"
        local now, best = workspace:GetServerTimeNow(), nil
        for _, _of in ipairs(candidates) do
            local other = _of.character
            if other.Parent and d.M.Motion.GetContext(other) == context
                and d.M.Teams.GetActorTeamName(_of.actor) == opposing then
                                                                                                 
                local untilTime = N.Tackle.GetSlidingUntil(other)
                local constants = N.Tackle.Constants
                local age = finite(untilTime) and now - (untilTime - constants.TotalMotionSeconds) or nil
                local _sg = constants.HitboxDelaySeconds + constants.HitboxSeconds
                local _sh = age ~= nil and age >= 0 and age <= _sg
                local kick = _sb(_of)
                if not _sh and not kick then continue end
                local hum = other:FindFirstChildOfClass("Humanoid")
                local _si = other:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and _si then
                    local otherCF = d.M.Motion.GetCFrame(other) or _si.CFrame
                    local _sj = d.M.Motion.GetVelocity(other) or _si.AssemblyLinearVelocity
                    if vector(otherCF.Position) and vector(_sj)
                        and (otherCF.Position - ownCF.Position).Magnitude <= C.Range then
                        local eta = _sh and contactTime(ownCF, velocity, otherCF, _sj, age) or nil
                        local _sk = kick and _sf(ownCF, velocity, otherCF, _sj, kick.first) or nil
                        local reason = "tackle"
                        if _sk and (not eta or _sk < eta) then eta, reason = _sk, "kick" end
                        local distance = flat(otherCF.Position - ownCF.Position).Magnitude
                        if eta and (not best or eta < best.eta or eta == best.eta and (distance or math.huge) < (best.distance or math.huge)) then
                            best = { character = other, eta = eta, distance = distance, reason = reason,
                                tackleAge = reason == "tackle" and age or nil,
                                hitboxRemaining = reason == "tackle" and _sg - age or nil,
                                kickChargeFill = reason == "kick" and kick.fill or nil,
                                earliestRelease = reason == "kick" and kick.first or nil }
                        end
                    end
                end
            end
        end
        if not best or not eligible() then return end
        stats.threats += 1
        local _sl = N.Controls.CreateInput("Dribble")
        assert(_sl and N.Controls.IsInput("Dribble", _sl), "Native dribble binding unavailable")
        _qw = os.clock() + C.RetrySeconds
        stats.attempts += 1
                                                                                       
                                                                            
        local attempt = { target = best.character.Name, contactSeconds = best.eta, distance = best.distance, reason = best.reason,
            tackleAgeSeconds = best.tackleAge, hitboxRemainingSeconds = best.hitboxRemaining,
            kickChargeFill = best.kickChargeFill, earliestReleaseSeconds = best.earliestRelease,
            serverConfirmed = false }
        if d.evaluation then
            d.evaluation.Dribble(attempt, function() d.M.Dodge.HandleInputBegan(_sl, false) end, best.character)
        else
            d.M.Dodge.HandleInputBegan(_sl, false)
        end
        local started = d.M.Dodge.IsDribbling() == true
        if started then
            stats.started += 1
            if best.reason == "kick" then stats.kickTriggers += 1 else stats.tackleTriggers += 1 end
        else
            stats.nativeBlocked += 1
        end
        A.DribbleStatus = started and "DRIBBLING" or "NATIVE BLOCKED"
        attempt.localStarted = started
        _ra[#_ra + 1] = attempt
        if #_ra > 8 then table.remove(_ra, 1) end
    end
                                                                              
    function A.ObserveDribbleGate()
        if not (alive and A.AutoDribble and d.alive()) then return nil end
        local ch, rootOrReason = eligible()
                                                                       
        local gate = ch and "ready" or rootOrReason
        if not ch then
            if gate ~= "COOLDOWN / BLOCKED" and gate ~= "DRIBBLING"
                and gate ~= "LOW STAMINA" and gate ~= "RETRY WAIT" then return nil end
            ch = d.Player.Character
        end
        if gate == "COOLDOWN / BLOCKED" then
            gate = N.Controls.IsOnCooldown("Dribble") and "cooldown" or "native_blocked"
        elseif gate == "DRIBBLING" then gate = "active"
        elseif gate == "LOW STAMINA" then gate = "low_stamina"
        elseif gate == "RETRY WAIT" then gate = "retry_wait" end
        return ch, gate
    end
    function A.SetAutoDribble(value)
        value = value == true
        _qk += 1
        local request = _qk
        if not value then
            A.AutoDribble = false
            _rd()
            A.DribbleStatus = "OFF"
            return true
        end
        if not alive or not d.alive() or _qi then return false end
        if A.AutoDribble then return true end
        _qi = true
        local ok, err = pcall(_rs)
        _qi = false
        if request ~= _qk or not alive or not d.alive() then return false end
        if not ok then _rr(err); return false end
        A.AutoDribble, A.DribbleStatus, nextTick = true, "WATCHING", 0
        local _sm, connectionError = pcall(function()
            _ru()
            _qm = d.Input.InputBegan:Connect(function(_sl)
                if not A.AutoDribble then return end
                local checked, inputError = pcall(function()
                    for _, name in ipairs({ "Kick", "Pass", "Lob", "RainbowFlick", "Dribble", "Tackle", "Jump" }) do
                        if N.Controls.IsInput(name, _sl) then _qv = os.clock() + C.ManualGrace; break end
                    end
                end)
                if not checked then _rr(_so) end
            end)
            heartbeat = d.Run.Heartbeat:Connect(function()
                if not (alive and A.AutoDribble and d.alive()) or os.clock() < nextTick then return end
                nextTick = os.clock() + C.Interval
                local start = os.clock()
                local _sp, tickError = pcall(tick)
                stats.maxTickMs = math.max(stats.maxTickMs, (os.clock() - start) * 1000)
                if not _sp then _rr(_sq) end
            end)
        end)
        if not _sm then _rr(_sn); return false end
        return true
    end
    function A.SetInfiniteStamina(value)
        value = value == true
        _ql += 1
        local request = _ql
        if value and (not alive or not d.alive() or _qj) then return false end
        if value and A.InfiniteStamina then return true end
        if not value and not _qz then
            local stopped, stopError = pcall(_re)
            A.InfiniteStamina = false
            A.StaminaStatus = stopped and "OFF" or "CLEANUP REQUIRED"
            if not stopped then _rc(_sr) end
            return stopped
        end
        _qj = true
        local ok, err = pcall(function()
            if not N.Sprint then N.Sprint = d.load("Client.Gameplay.Player.Sprint") end
            assert(type(N.Sprint.SetUnlimitedStamina) == "function", "Native stamina switch unavailable")
            if value and not N.Guard then N.Guard = d.load("Modules.Characters.LocalMovementGuard") end
            if value then
                N.Placement = N.Placement or d.load("Modules.Characters.CharacterPlacement")
                N.StaminaRules = N.StaminaRules or d.load("Modules.Actions.Sprint")
                assert(type(N.Sprint.GetStamina) == "function" and type(N.Sprint.SpendStamina) == "function"
                    and type(N.StaminaRules.GetStaminaMultiplier) == "function", "Native stamina recovery unavailable")
            end
            if value and (request ~= _ql or not alive or not d.alive()) then return end
            if value then _rm() end
                                                                                          
                                                                                   
            if value then _qz = true end
            N.Sprint.SetUnlimitedStamina(_qy, value)
            _qz = value
            if not value then _re() end
        end)
        _qj = false
        if not ok then
            if value and _qz then
                local _ss = pcall(N.Sprint.SetUnlimitedStamina, _qy, false)
                if _ss then _qz = false end
            end
            if not _qz then pcall(_re) end
            A.InfiniteStamina = _qz
            A.StaminaStatus = _qz and "CLEANUP REQUIRED" or "ERROR"
            _rc(err)
            return false
        end
        if value and (request ~= _ql or not alive or not d.alive()) then return false end
        A.InfiniteStamina = value
        if value then _qr, nextStaminaRetry = nil, 0 end
        A.StaminaStatus = value and "LOCAL ON" or "OFF"
        return true
    end
    function A.Cleanup()
        alive = false
        A.SetAutoDribble(false)
        return A.SetInfiniteStamina(false)
    end
    function A.Debug()
        return { autoDribble = A.AutoDribble, infiniteStamina = A.InfiniteStamina,
            dribbleStatus = A.DribbleStatus, staminaStatus = A.StaminaStatus,
            staminaServerVerified = false, lastError = A.LastError, version = "Misc 0.6",
            dribbleTrigger = "incoming_tackle_or_kick", tackleLookaheadSeconds = C.Lookahead,
            kickLookaheadSeconds = C.KickLookahead,
            correctionFallback = true, positionRepairFallback = true,
            lastCorrection = _rb and table.clone(_rb) or nil,
            stats = table.clone(stats), recent = table.clone(_ra) }
    end
    if d.test then A.Test = { contactTime = contactTime, segmentBox = _rx, kickContactTime = _sf } end
    return A
end

                                                                                      
local function _st(d)
    local A = {}
    local alive, sequence, heartbeat = true, 0, nil
    local _su, _sv, connections = {}, {}, {}
    local pending, dribbleScopes = {}, setmetatable({}, { __mode = "k" })
    local mainThread, hooks = {}, {}
    local _sy, _sz, probe, settingsProbe = nil, 0, nil, nil
    local _tb, _tc, _td, roster = {}, {}, {}, {}
    local _tf, encounterSequence = 0, 0
    local _th, _ti, encounterContext = nil, nil, nil
    local _tk
    local nextTick = 0
    local stats = { shots = 0, dribbles = 0, exactFlightMatches = 0, shotRejections = 0,
        dribbleRejections = 0, attributeDribbles = 0, unmatchedMovements = 0,
        unreadableMovements = 0, errors = 0, maxMaintenanceMs = 0, maxCallbackMs = 0,
        proximitySamples = 0, encounters = 0, droppedShots = 0, droppedDribbles = 0, droppedEncounters = 0 }
    local _tl, movementFields = nil, nil
    local function finite(n) return type(n) == "number" and n == n and math.abs(n) < math.huge end
    local function _tn(v) return type(v) == "string" or type(v) == "boolean" or finite(v) end
    local function vector(v) return typeof(v) == "Vector3" and finite(v.X) and finite(v.Y) and finite(v.Z) end
    local function _to(value, depth)
        if _tn(value) then return value end
        if type(value) ~= "table" or (depth or 0) >= 5 then return nil end
        local out = {}
        for k, v in pairs(value) do
            if type(k) == "string" or type(k) == "number" then out[k] = _to(v, (depth or 0) + 1) end
        end
        return out
    end
    local function _tp(fn, ...)
        local began = os.clock()
        local result = table.pack(pcall(fn, ...))
        stats.maxCallbackMs = math.max(stats.maxCallbackMs, (os.clock() - began) * 1000)
        if not result[1] then
            stats.errors += 1
            _tl = tostring(result[2])
            return nil
        end
        return table.unpack(result, 2, result.n)
    end
    local function close(_qa, reason)
        if _qa.closed then return end
        _qa.closed = true
        _qa.observationEnd = reason
        pending[_qa] = nil
        if _qa.attributeConnection then
            _qa.attributeConnection:Disconnect()
            _qa.attributeConnection = nil
        end
        _qa.character, _qa.goal, _qa.mouth = nil, nil, nil
        _qa.predictedPosition, _qa.lastPosition = nil, nil
    end
    local function _tq(_qa)
        return _qa.character == d.Player.Character
            and _qa.context == d.M.Motion.GetContext(d.Player.Character)
            and _qa.ballId == d.M.Renderer.GetMatchBallId()
    end
    local function step()
        local now = os.clock()
        for _qa in pairs(pending) do
            if not _tq(_qa) then
                close(_qa, "context_changed")
            elseif now >= _qa.deadline then
                if _qa.kind == "dribble" then
                    _qa.localOwnerAtWindowEnd = d.M.Renderer.GetOwnedUserId() == d.Player.UserId
                end
                close(_qa, "window_ended")
            end
        end
        if _sy and _tk then _tk(now) end
        if not _sy and not next(pending) and heartbeat then heartbeat:Disconnect(); heartbeat = nil end
    end
    local function _tr(_qa)
        if _qa then pending[_qa] = true end
        if heartbeat then return end
        nextTick = 0
        heartbeat = d.Run.Heartbeat:Connect(function()
            if not alive or not d.alive() then return end
            local now = os.clock()
            if now < nextTick then return end
            nextTick = now + 0.1
            local began = now
            _tp(step)
            stats.maxMaintenanceMs = math.max(stats.maxMaintenanceMs, (os.clock() - began) * 1000)
        end)
    end
    local function _ts(kind, detail)
        if not alive or not d.alive() then return nil end
        sequence += 1
        local r = _to(detail or {})
        r.id, r.kind, r.observedAt = sequence, kind, os.clock()
        r.build, r.trialId = d.build or "unlabelled_build", _sy and _sy.id or nil
        r.sessionIdTag = d.sessionId
        r.trialLabel, r.scenario = _sy and _sy.label or nil, _sy and _sy.scenario or nil
        r.settings = _sy and _ta and _to(_tp(_ta)) or nil
        r.recordedAtMilliseconds = d.timestamp and d.timestamp() or nil
        r.context = d.M.Motion.GetContext(d.Player.Character)
        r.ballId = d.M.Renderer.GetMatchBallId()
        r.character = d.Player.Character
        r.deadline = r.observedAt + (kind == "shot" and 8 or 1.5)
        r.serverStatus = "unconfirmed"
        if _sy then _sy[kind == "shot" and "shots" or "dribbles"] += 1 end
        local list = kind == "shot" and _su or _sv
        list[#list + 1] = r
        if #list > 40 then
            close(table.remove(list, 1), "record_limit")
            local key = kind == "shot" and "droppedShots" or "droppedDribbles"
            stats[key] += 1
        end
        if kind == "shot" then stats.shots += 1 else stats.dribbles += 1 end
        _tr(r)
        return r
    end
    local function _tt(reason)
        for character, _qa in pairs(_td) do
            _qa.observationEnd = reason
            _td[character] = nil
        end
    end
    local function _tu(character, gate, distance, now)
        if not _sy or not character then return nil end
        local r = _td[character]
        local context, ball = d.M.Motion.GetContext(d.Player.Character), d.M.Renderer.GetMatchBallId()
        if _th ~= d.Player.Character or _ti ~= ball or _tj ~= context then
            _tt("context_changed")
            _th, _ti, encounterContext = d.Player.Character, ball, context
            r = nil
        end
        if r and (now - r.lastObservedAt > 0.35 or r.context ~= context or r.ballId ~= ball) then
            r.observationEnd = "separated_or_context_changed"
            _td[character], r = nil, nil
        end
        if not r then
            _tg += 1
            r = { id = _tg, build = d.build or "unlabelled_build", trialId = _sy.id,
                sessionIdTag = d.sessionId,
                trialLabel = _sy.label, scenario = _sy.scenario, target = character.Name,
                context = context, ballId = ball, observedAt = now, firstGate = gate,
                gates = {}, attemptIds = {} }
            _td[character] = r
            _tc[#_tc + 1] = r
            stats.encounters += 1
            if #_tc > 60 then
                local old = table.remove(_tc, 1)
                for key, value in pairs(_td) do if value == old then _td[key] = nil end end
                stats.droppedEncounters += 1
            end
        end
        r.lastObservedAt = now
        r.gates[gate] = true
        if gate == "eligible" then r.firstEligibleAt = r.firstEligibleAt or now end
        if finite(distance) then r.minimumDistance = math.min(r.minimumDistance or math.huge, distance) end
        return r
    end
    _tk = function(now)
        if not probe or not d.Players then return end
                                                                               
        if _sy.nextSample and now < _sy.nextSample then return end
        _sy.nextSample = now + 0.1
        local ch, gate = probe()
        if not ch then _tt("not_observing"); return end
        local team = d.M.Teams.GetActorTeamName(d.Player)
        local opposing = d.M.Match.Constants.TeamDisplayNames[team] and d.M.Match.GetOpposingTeamName(team)
        local ownCF = d.M.Motion.GetCFrame(ch)
        if not opposing or not ownCF or not vector(ownCF.Position) then _tt("unavailable_context"); return end
        if now >= _tf then
            local seen = {}
            _te = {}
            local function add(character, actor)
                if not character or character == ch or seen[character] then return end
                seen[character] = true
                if #_te >= 128 then _sy.rosterTruncated = true; return end
                _te[#_te + 1] = { character = character, actor = actor or character }
            end
            for _, _j in ipairs(d.Players:GetPlayers()) do add(_j.Character, _j) end
            local folder = workspace:FindFirstChild("Characters")
            for _, container in ipairs({ folder, folder and folder:FindFirstChild("NPCs") }) do
                for _, child in ipairs(container:GetChildren()) do if child:IsA("Model") then add(child) end end
            end
            _tf = now + 0.5
        end
        stats.proximitySamples += 1
        for _, entry in ipairs(_te) do
            local other = entry.character
            local hum = other.Parent and other:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 and d.M.Motion.GetContext(other) == d.M.Motion.GetContext(ch)
                and d.M.Teams.GetActorTeamName(entry.actor) == opposing then
                local otherCF = d.M.Motion.GetCFrame(other)
                if otherCF and vector(otherCF.Position) then
                    local delta = otherCF.Position - ownCF.Position
                    local distance = Vector3.new(delta.X, 0, delta.Z).Magnitude
                    local radius = _td[other] and 10.5 or 9
                    if math.abs(delta.Y) <= 5 and distance <= radius then _tu(other, gate, distance, now) end
                end
            end
        end
        for character, r in pairs(_td) do
            if now - r.lastObservedAt > 0.35 then
                r.observationEnd = "left_proximity"
                _td[character] = nil
            end
        end
    end
    function A.ConfigureComparison(readGate, readSettings)
        probe, settingsProbe = readGate, readSettings
    end
    function A.BeginTrial(label, scenario)
        if not alive or not d.alive() then return false, "Script is unloaded" end
        if _sy then return false, "End and export the current run first" end
        if type(label) ~= "string" or not label:find("%S") or #label > 64
            or type(scenario) ~= "string" or not scenario:find("%S") or #scenario > 64 then
            return false, "Use a run label and scenario, each 1-64 characters"
        end
        local _tv = _ta and _tp(_ta) or nil
        if _ta and type(_tv) ~= "table" then return false, "Settings snapshot unavailable" end
        _sz += 1
        _sy = { id = _sz, label = label, scenario = scenario, build = d.build or "unlabelled_build",
            startedAt = os.clock(), settings = _to(_tv), firstAttemptId = sequence + 1, shots = 0, dribbles = 0 }
        _tb[#_tb + 1] = _sy
        if #_tb > 12 then table.remove(_tb, 1) end
        _tf = 0
        _tr(nil)
        return true, _sy.id
    end
    function A.EndTrial()
        if not _sy then return false, "No active comparison run" end
        local _tw = _sy.id
        _sy.endedAt, _sy.lastAttemptId = os.clock(), sequence
        _tt("run_ended")
        _sy, roster = nil, {}
        _tp(step)
        return true, _tw
    end
    local function _tx(command)
        if type(command) ~= "table" then return end
        local _ty = command.Kind == "Kick" or command.Kind == "RainbowFlick"
            or command.Kind == "Tackle" and (command.Mode == "Kick" or command.Mode == "Volley")
        if not _ty then return end
        for r in pairs(pending) do
            if r.kind == "dribble" and _tq(r) then
                r.strikeIntent = command.PassType or command.Kind
                r.strikeActionId, r.strikeSessionId = command.ActionId, command.SessionId
                close(r, "strike_intent")
            end
        end
    end
    local function _tz(detail, frame, command, predictedPosition)
        local r = _ts("shot", detail)
        if not r then return end
                                                                                           
        r.sessionId, r.actionId = command.SessionId, command.ActionId
        r.charge = command.ChargeSeconds
        r.curve = command.Curve or 0
        r.predictionComparable = frame ~= nil and frame.character == r.character
            and frame.context == r.context and frame.ballId == r.ballId
        if r.predictionComparable then
            r.goal = frame.goal
                                                                                         
            r.predictedPosition = predictedPosition
            r.mouth = frame.mouth
        end
        detail.evaluationId = r.id
    end
    local function _ua(detail, target)
        local r = _ts("dribble", detail)
        if not r then return end
        detail.evaluationId = r.id
        local _ub = _tu(target, "eligible", detail.distance, os.clock())
        if _ub then
            r.encounterId = _ub.id
            if #_ub.attemptIds == 0 then r.observedEligibleDelaySeconds = os.clock() - _ub.firstEligibleAt end
            _ub.attemptIds[#_ub.attemptIds + 1] = r.id
        end
        local character = r.character
        if character and type(character.GetAttributeChangedSignal) == "function" then
                                                                            
            local _uc = character:GetAttribute("Dribbling") ~= true
            r.attributeConnection = character:GetAttributeChangedSignal("Dribbling"):Connect(function()
                _tp(function()
                    if r.closed or not alive or not _tq(r) or os.clock() > r.deadline then return end
                    local active = character:GetAttribute("Dribbling") == true
                    if not active then _uc = true end
                    if active and _uc and not r.dribblingAttributeObserved then
                        r.dribblingAttributeObserved = true
                        stats.attributeDribbles += 1
                    end
                end)
            end)
        end
        return r
    end
    function A.Dribble(detail, invoke, target)
        local r = _tp(_ua, detail, target)
        local key = coroutine.running() or mainThread
        local previous = _sx[key]
        _sx[key] = r
        local result = table.pack(pcall(invoke))
        _sx[key] = previous
        _tp(function()
            if not r then return end
            r.localStarted = result[1] and d.M.Dodge.IsDribbling() == true
            if not r.localStarted then close(r, result[1] and "native_did_not_start" or "native_error") end
        end)
                                                                                    
        if not result[1] then error(result[2], 0) end
        return table.unpack(result, 2, result.n)
    end
    local function _ud(packet)
        if type(packet) ~= "table" or type(packet.Command) ~= "table" then return end
        if not ((packet.Protocol == "ActionCommand" and packet.Phase == "ExecuteRejected")
            or (packet.Protocol == "ActionSession" and packet.Phase == "StartRejected")) then return end
        local command = packet.Command
        for _, list in ipairs({ _su, _sv }) do
            for _, r in ipairs(list) do
                local matched = r.kind == "dribble" and command.Mode == "Dodge"
                    and r.actionId ~= nil and command.ActionId == r.actionId
                    or r.kind == "shot" and command.PassType == "Shot"
                    and ((r.sessionId ~= nil and command.SessionId == r.sessionId)
                        or (r.actionId ~= nil and command.ActionId == r.actionId))
                if matched and not r.rejected then
                    r.rejected, r.serverStatus = true, "rejected"
                    if r.kind == "shot" then stats.shotRejections += 1 else stats.dribbleRejections += 1 end
                    close(r, "server_rejected")
                end
            end
        end
    end
    local function _ue(r, state)
        return state.ActionId ~= nil and (state.ActionId == r.actionId or state.ActionId == r.sessionId)
            and state.LastKickerUserId == d.Player.UserId and state.LastPassType == "Shot"
    end
    local function _uf(packet)
        if type(packet) ~= "table" or packet.BallId == nil then return end
        if packet.Kind == "Movement" then
            local _ug = false
            for r in pairs(pending) do
                if r.kind == "shot" and r.ballId == packet.BallId then _ug = true; break end
            end
            if not _ug then return end
                                                                                        
            local state = type(packet.State) == "table" and packet.State or packet
            if not vector(state.Position) or not finite(state.UpdatedAt or state.StartedAt) then
                stats.unreadableMovements += 1
                if not _tm then
                    local _uh = {}
                    for key in pairs(packet) do _uh[#_uh + 1] = tostring(key) end
                    table.sort(_uh); _tm = table.concat(_uh, ",")
                end
                return
            end
            local matched = false
            for r in pairs(pending) do
                if r.kind == "shot" and r.ballId == packet.BallId and _tq(r) then
                    if _ue(r, state) then
                        matched = true
                        if not r.flightMatched then
                            r.flightMatched, r.serverStatus = true, "flight_observed"
                            stats.exactFlightMatches += 1
                        end
                        local _ui = state.UpdatedAt or state.StartedAt
                        if not r.lastStateTime or _ui > r.lastStateTime then
                                                                                                  
                            local mouth, old = r.mouth, r.lastPosition
                            if mouth and old and not r.crossingObserved then
                                local a, b = (old - mouth.plane):Dot(mouth.forward), (state.Position - mouth.plane):Dot(mouth.forward)
                                if a > 0 and b <= 0 then
                                    local crossing = old:Lerp(state.Position, a / (a - b))
                                    r.crossingObserved = true
                                    r.crossingInsideOpening = math.abs((crossing - mouth.center):Dot(mouth.lateral)) <= mouth.halfWidth
                                        and crossing.Y >= mouth.bottom and crossing.Y <= mouth.top
                                    r.crossingSampleGapSeconds = _ui - r.lastStateTime
                                    if vector(r.predictedPosition) then r.crossingPredictionErrorStuds = (crossing - r.predictedPosition).Magnitude end
                                end
                            end
                            r.lastPosition, r.lastStateTime = state.Position, _ui
                        end
                    elseif r.flightMatched and state.ActionId ~= nil and state.ActionId ~= r.actionId and state.ActionId ~= r.sessionId
                        and (state.UpdatedAt or state.StartedAt) > (r.lastStateTime or -math.huge) then
                        close(r, "different_flight")
                    end
                end
            end
            if not matched then stats.unmatchedMovements += 1 end
        elseif packet.Kind == "Owned" then
            if not finite(packet.OwnerUserId) then return end
            for r in pairs(pending) do
                if r.ballId == packet.BallId and _tq(r) then
                    if r.kind == "shot" and r.flightMatched then
                        r.ownerAfterFlight = packet.OwnerUserId
                        r.catchFlagObserved = packet.IsDiveCatch == true or packet.IsGoalkeeperJumpCatch == true
                        r.serverStatus = r.catchFlagObserved and "catch_after_flight" or "ownership_after_flight"
                        close(r, "ownership_changed")
                    elseif r.kind == "dribble" and packet.OwnerUserId ~= d.Player.UserId then
                        r.serverPossessionLost = true
                        r.ownerAfterDribble = packet.OwnerUserId
                        close(r, "possession_changed")
                    end
                end
            end
        elseif packet.Kind == "Removed" then
            for r in pairs(pending) do if r.ballId == packet.BallId then close(r, "ball_removed") end end
        end
    end
    local allowed = { shot = { goal = true, saved = true, blocked = true, miss = true, unclear = true },
        dribble = { kept_ball = true, lost_ball = true, interrupted = true, unclear = true } }
    function A.Mark(kind, _qf, _tw)
        if not allowed[kind] or not allowed[kind][_qf] then return false, "Unknown kind or outcome" end
        local list = kind == "shot" and _su or _sv
        for i = #list, 1, -1 do
            local r = list[i]
            if _tw == nil or r.id == _tw then
                r.userOutcome, r.outcomeSource = _qf, "user_reported"
                return true, r.id
            end
        end
        return false, "No matching recorded attempt"
    end
    function A.MarkTrial(kind, labels, trialId)
        if not allowed[kind] or type(labels) ~= "string" then return false, "Use shot/dribble and a space-separated result list" end
        local _uj = nil
        for i = #_tb, 1, -1 do
            if trialId == nil or _tb[i].id == trialId then _uj = _tb[i]; break end
        end
        if not _uj or not _uj.endedAt then return false, "End the run before labelling it" end
        local values, records = {}, {}
        for value in labels:gmatch("%S+") do
            if not allowed[kind][value] then return false, "Unknown outcome: " .. value end
            values[#values + 1] = value
        end
        for _, r in ipairs(kind == "shot" and _su or _sv) do
            if r.trialId == _uj.id then _uk[#_uk + 1] = r end
        end
        if #_uk ~= _uj[kind == "shot" and "shots" or "dribbles"] then
            return false, "Some records expired; label retained attempts by ID instead"
        end
        if #_uk == 0 or #_uk ~= #values then
            return false, "Expected " .. tostring(#_uk) .. " outcomes in attempt order; no labels changed"
        end
        for i, r in ipairs(_uk) do r.userOutcome, r.outcomeSource = values[i], "user_reported" end
        return true, #_uk
    end
    local function _ul(list)
        local out = {}
        for _, r in ipairs(list) do
            local _um = {}
            for key, value in pairs(r) do
                if key ~= "character" and key ~= "goal" and key ~= "mouth" and key ~= "attributeConnection"
                    and key ~= "predictedPosition" and key ~= "lastPosition" then _um[key] = _to(value) end
            end
            out[#out + 1] = _um
        end
        return out
    end
    function A.Report()
        _tp(step)
        local _un = { shots = {}, dribbles = {} }
        for _, entry in ipairs({ { _su, _un.shots }, { _sv, _un.dribbles } }) do
            for _, r in ipairs(entry[1]) do
                local label = r.userOutcome or "unlabelled"
                entry[2][label] = (entry[2][label] or 0) + 1
            end
        end
        local _uo = { localStarts = 0, localRetainedAtWindowEnd = 0, ownershipLossObserved = 0,
            strikeInterruptions = 0, rejected = 0, unresolved = 0 }
        for _, r in ipairs(_sv) do
            if r.localStarted then _uo.localStarts += 1 end
            if r.rejected then _uo.rejected += 1
            elseif r.strikeIntent then _uo.strikeInterruptions += 1
            elseif r.serverPossessionLost then _uo.ownershipLossObserved += 1
            elseif r.localOwnerAtWindowEnd == true then _uo.localRetainedAtWindowEnd += 1
            else _uo.unresolved += 1 end
        end
        return { version = "Evaluation 0.2", build = d.build or "unlabelled_build", sessionIdTag = d.sessionId,
            stats = table.clone(stats), lastError = _tl,
            rawMovementFields = _tm, recentShots = _ul(_su), recentDribbles = _ul(_sv),
            recentEncounters = _to(_tc), trials = _to(_tb), activeTrialId = _sy and _sy.id or nil,
            dribbleObservations = _uo, encounterSampling = "10 Hz during a run; 9-stud entry, 10.5-stud exit, 0.35s separation; sampled proximity, not every tackle",
            userReportedOutcomes = _un, outcomeWindow = "last 40 of each kind",
            automaticGoalConfirmation = false, globalBestShotProven = false }
    end
    function A.Call(name, ...)
        if name == "ShotSent" then return _tp(_tz, ...) end
        return nil
    end
    function A.Cleanup()
        alive = false
        if _sy then A.EndTrial() end
        for r in pairs(pending) do _tp(close, r, "unloaded") end
        if heartbeat then heartbeat:Disconnect(); heartbeat = nil end
        for _, c in ipairs(_sw) do c:Disconnect() end
        table.clear(_sw)
        for name, hook in pairs(hooks) do
            if d.M.Protocol[name] == hook.wrapper then d.M.Protocol[name] = hook.original end
        end
        return true
    end
    _tp(function()
        for _, name in ipairs({ "Send", "Release" }) do
            local hook = { original = d.M.Protocol[name] }
            if type(hook.original) ~= "function" then continue end
            hook.wrapper = function(command, ...)
                if not alive or not d.alive() then return hook.original(command, ...) end
                local r = _sx[coroutine.running() or mainThread]
                if not r and not next(pending) then return hook.original(command, ...) end
                local result = table.pack(hook.original(command, ...))
                _tp(function()
                    if r and command.Mode == "Dodge" then r.actionId = command.ActionId or result[1] end
                    _tx(command)
                end)
                return table.unpack(result, 1, result.n)
            end
            hooks[name] = hook
            d.M.Protocol[name] = hook.wrapper
        end
        _sw[#_sw + 1] = d.State.OnClientEvent:Connect(function(packet)
            if alive and d.alive() and next(pending) then _tp(_uf, packet) end
        end)
        for _, remote in ipairs(d.CommandRemotes) do
            _sw[#_sw + 1] = remote.OnClientEvent:Connect(function(packet)
                if alive and d.alive() then _tp(_ud, packet) end
            end)
        end
    end)
    return A
end

local _up = {}
for _, remote in ipairs(_w:GetChildren()) do
    if remote ~= _y and (remote:IsA("RemoteEvent") or remote:IsA("UnreliableRemoteEvent")) then
        _up[#_up + 1] = remote
    end
end
local _uq = _st({
    M = M, Player = _p, Players = Players, Run = RunService, State = _y,
    build = "Dmc 0.23 startup and shot selection",
    sessionId = game:GetService("HttpService"):GenerateGUID(false),
    CommandRemotes = _up, alive = function() return S.alive end,
    timestamp = function() return DateTime.now().UnixTimestampMillis end,
})
S.releaseEvaluation = _uq.Cleanup
_s.DmcEvaluationReport = function()
    local result = _uq.Report()
    local _ur = game:GetService("HttpService")
    local _us = table.clone(result)
    _us.recentShots, _us.recentDribbles, _us.recentEncounters = nil, nil, nil
    print("[Dmc Evaluation]", _ur:JSONEncode(_us))
    for _, _qa in ipairs(result.recentShots) do print("[Dmc Shot]", _ur:JSONEncode(_qa)) end
    for _, _qa in ipairs(result.recentDribbles) do print("[Dmc Dribble]", _ur:JSONEncode(_qa)) end
    for _, _qa in ipairs(result.recentEncounters) do print("[Dmc Encounter]", _ur:JSONEncode(_qa)) end
    return result
end
_s.DmcBeginTrial = function(label, scenario)
    local ok, detail = _uq.BeginTrial(label, scenario)
    print("[Dmc Evaluation]", ok and "Run started" or "Not started", detail)
    return ok, detail
end
_s.DmcEndTrial = function()
    local ok, detail = _uq.EndTrial()
    print("[Dmc Evaluation]", ok and "Run ended" or "Not ended", detail)
    return _s.DmcEvaluationReport()
end
_s.DmcMarkTrial = function(kind, _un, trialId)
    local ok, detail = _uq.MarkTrial(kind, _un, trialId)
    print("[Dmc Evaluation]", ok and "Run outcomes recorded" or "Not recorded", detail)
    if ok then return _s.DmcEvaluationReport() end
    return ok, detail
end
_s.DmcMarkOutcome = function(kind, _qf, _tw)
    local ok, detail = _uq.Mark(kind, _qf, _tw)
    print("[Dmc Evaluation]", ok and "Outcome recorded" or "Not recorded", detail)
    return ok, detail
end
local _ut = _ig({
    M = M, Player = _p, Players = Players, Input = UserInputService,
    load = _v, alive = function() return S.alive end,
    uiBusy = function() return S.uiBusy end, evaluation = _uq,
})
S.releaseStriker = _ut.Cleanup
_s.AutoSTR = _ut
_s.AutoSTRDebug = function()
    local result = _ut.Debug()
    print("[Auto STR]", game:GetService("HttpService"):JSONEncode(result))
    return result
end
local _uu = _qh({
    M = M, Player = _p, Players = Players, Input = UserInputService,
    Run = RunService, Gui = game:GetService("GuiService"), load = _v,
    id = game:GetService("HttpService"):GenerateGUID(false),
    alive = function() return S.alive end,
    suspended = function() return S.uiBusy or not S.focused end, evaluation = _uq,
})
S.releaseMisc = _uu.Cleanup
_uq.ConfigureComparison(_uu.ObserveDribbleGate, function()
    return { bestShot = _ut.Enabled, autoCurve = _ut.AutoCurve, smartRelease = _ut.SmartRelease,
        autoDribble = _uu.AutoDribble, infiniteStamina = _uu.InfiniteStamina }
end)
_s.DmcMisc = _uu
_s.DmcMiscDebug = function()
    local result = _uu.Debug()
    print("[Dmc Misc]", game:GetService("HttpService"):JSONEncode(result))
    return result
end

                                                                
                     
                                                                

local function _uv(value)
    _s.AUTO_GK_ENABLED = value == true
    S.nextPlanAt = 0

    if _s.AUTO_GK_ENABLED then
        S.runtimeFailures = 0
        S.runtimeRetryAt = 0
        S.runtimeError = nil
    end

    if not _s.AUTO_GK_ENABLED then
        _fn(true)
        _ag("OFF", "Manual controls untouched")
    end
end

                                                                
            
                                                                

do
    local _uw = _q:FindFirstChild("AutoGKInterface")
    if _uw then _uw:Destroy() end

    local C = {
        background = Color3.fromRGB(16, 16, 15),
        surface = Color3.fromRGB(23, 23, 21),
        control = Color3.fromRGB(29, 29, 26),
        hover = Color3.fromRGB(39, 37, 30),
        pressed = Color3.fromRGB(53, 47, 32),
        stroke = Color3.fromRGB(49, 47, 39),
        text = Color3.fromRGB(233, 231, 220),
        muted = Color3.fromRGB(145, 144, 131),
        accent = Color3.fromRGB(222, 193, 115),
        accentDim = Color3.fromRGB(131, 111, 61),
        active = Color3.fromRGB(43, 39, 27),
    }

    local function _ux(class, properties, _k)
        local object = Instance.new(class)
        for key, value in pairs(properties) do object[key] = value end
        object.Parent = _k
        return object
    end

    local function _uy(object, radius)
        _ux("UICorner", { CornerRadius = UDim.new(0, radius) }, object)
        return object
    end

    local function _uz(object, _we, thickness)
        return _ux("UIStroke", {
            Color = _we or C.stroke,
            Thickness = thickness or 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }, object)
    end

    local function frame(_k, name, x, y, w, h, _we)
        return _ux("Frame", {
            Name = name, Position = UDim2.fromOffset(x, y),
            Size = UDim2.fromOffset(w, h), BackgroundColor3 = _we or C.surface,
            BorderSizePixel = 0,
        }, _k)
    end

    local function _va(_k, value, size, properties)
        local p = {
            Text = value, TextSize = size, Font = Enum.Font.Gotham,
            TextColor3 = C.text, BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
        }
        for key, v in pairs(properties or {}) do p[key] = v end
        return _ux("TextLabel", p, _k)
    end

    local function _vb(_k, properties)
        local p = {
            Text = "", TextSize = 12, Font = Enum.Font.GothamMedium,
            TextColor3 = C.text, BackgroundColor3 = C.control,
            BorderSizePixel = 0, AutoButtonColor = false,
            Modal = false, Selectable = true,
        }
        for key, value in pairs(properties) do p[key] = value end
        return _uy(_ux("TextButton", p, _k), 5)
    end

    local _vc = _ux("ScreenGui", {
        Name = "AutoGKInterface", ResetOnSpawn = false, Enabled = true,
        IgnoreGuiInset = true, DisplayOrder = 20,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, _q)
    S.ui = _vc

                                                                                
    local _vd = _ux("Frame", {
        Name = "WindowHost", Position = UDim2.fromOffset(20, 138),
        Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1,
        BorderSizePixel = 0,
    }, _vc)
    local panel = _uy(frame(_vd, "Panel", 0, 0, 316, 494, C.background), 9)
    panel.Active = true
    _uz(panel, C.accentDim)
    local _ve = _ux("UIScale", { Scale = 1 }, panel)
    local _vf = frame(panel, "DragHandle", 12, 0, 224, 40)
    _vf.BackgroundTransparency = 1
    _vf.Active = true
    _va(_vf, "Banyu", 13, {
        Name = "PageTitle", Size = UDim2.fromScale(1, 1),
        Font = Enum.Font.GothamBold,
    })
    local _vg = _vb(panel, {
        Name = "Minimize", Text = "-", TextSize = 18,
        Position = UDim2.new(1, -68, 0, 8), Size = UDim2.fromOffset(24, 24),
    })
    local _vh = _vb(panel, {
        Name = "Unload", Text = "x", TextSize = 12,
        Position = UDim2.new(1, -36, 0, 8), Size = UDim2.fromOffset(24, 24),
    })
    local _vi = frame(panel, "Tabs", 12, 44, 292, 26)
    _vi.BackgroundTransparency = 1
                                                              
    local _vj = frame(panel, "STRContent", 12, 76, 292, 406)
    _vj.BackgroundTransparency = 1
    _vj.Visible = false
    local _vk = _uy(frame(panel, "LiveStatus", 12, 76, 292, 28, C.surface), 5)
    local _vl = _uy(frame(_vk, "StatusDot", 10, 11, 6, 6, C.muted), 3)
    local _vm = _va(_vk, "STARTING", 10, {
        Name = "Status", Position = UDim2.fromOffset(24, 0),
        Size = UDim2.new(1, -34, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd,
    })
                                                                             
    local _vn = _ux("ScrollingFrame", {
        Name = "MainContent", Position = UDim2.fromOffset(12, 114),
        Size = UDim2.fromOffset(292, 368), BackgroundTransparency = 1,
        BorderSizePixel = 0, ClipsDescendants = true,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollBarThickness = 2, ScrollBarImageColor3 = C.accentDim,
        CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, panel)
    _ux("UIListLayout", {
        Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
    }, _vn)
    local _vo = {}
    local _vp = {}
    local _vq = {}
    local _vr = {}
    local _vs = nil
    local _vt = false
    local _vu = false
    local _vv = "GK"
    local _vw = nil
    local _vx = 0

    local function _vy(object)
        if _vq[object] then _vq[object]:Disconnect() end
        _vq[object] = nil
        if _vp[object] then _vp[object]:Cancel() end
        _vp[object] = nil
    end

    local function _vz(object, _jc, _ai, duration, onComplete)
        _vy(object)
        if _ai then
            for k, v in pairs(_jc) do object[k] = v end
            if onComplete then onComplete() end
            return
        end
        local _wa = TweenService:Create(object,
            TweenInfo.new(duration or 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), _jc)
        _vp[object] = _wa
        _vq[object] = _wa.Completed:Connect(function(playbackState)
                                                                                                     
            if _vp[object] ~= _wa then return end
            local _wb = _vq[object]
            if _wb then _wb:Disconnect() end
            _vq[object] = nil
            _vp[object] = nil
            if playbackState == Enum.PlaybackState.Completed and S.alive and onComplete then
                onComplete()
            end
        end)
        _wa:Play()
    end

    S.cancelUITweens = function()
        for object in pairs(_vp) do
            _vy(object)
        end
    end

    local function _wc(object, baseColor)
        local _wd, held, previous = false, nil, nil
        local function draw(_ai)
            local _we = held and C.pressed or _wd and C.hover
                or (baseColor and baseColor() or C.control)
            if _we == previous then return end
            previous = _we
            _vz(object, { BackgroundColor3 = _we }, _ai, held and 0.07 or 0.14)
        end
        local function reset()
            _wd, held = false, nil
            if S.alive then draw(false) end
        end
        _ac(object.MouseEnter, function()
            if not S.alive then return end
            _wd = true
            draw(false)
        end)
        _ac(object.MouseLeave, reset)
        _ac(object.InputBegan, function(_sl)
            if not S.alive or object.Interactable == false then return end
            if _sl.UserInputType == Enum.UserInputType.MouseButton1
                or _sl.UserInputType == Enum.UserInputType.Touch then
                held = _sl
                draw(false)
            end
        end)
        _ac(UserInputService.InputEnded, function(_sl)
            if not S.alive or not held then return end
            if _sl == held or (held.UserInputType == Enum.UserInputType.MouseButton1
                and _sl.UserInputType == Enum.UserInputType.MouseButton1) then
                held = nil
                draw(false)
            end
        end)
        _ac(UserInputService.WindowFocusReleased, reset)
        draw(true)
        return draw, reset
    end
    _wc(_vg)
    _wc(_vh)

    local function _wf(_ai)
        local previous = _vs
        _vs = nil
        if _ai then
            for _, entry in ipairs(_vr) do entry.setOpen(false, true) end
        elseif previous then
            previous.setOpen(false, false)
        end
        S.uiBusy = _vt
    end
    S.closeDropdown = function() _wf(true) end

    local function _wg(point, object)
        local p, size = object.AbsolutePosition, object.AbsoluteSize
        return point.X >= p.X and point.X <= p.X + size.X
            and point.Y >= p.Y and point.Y <= p.Y + size.Y
    end

    local function _wh(name)
        local _wi = frame(_vn, name, 0, 0, 0, 22)
        _wi.Size = UDim2.new(1, -4, 0, 22)
        _wi.BackgroundTransparency = 1
        _wi.AutomaticSize = Enum.AutomaticSize.Y
        _wi.LayoutOrder = name == "AUTOMATION" and 1 or 2
        _va(_wi, name, 9, {
            Position = UDim2.fromOffset(0, 0), Size = UDim2.new(1, 0, 0, 16),
            Font = Enum.Font.GothamMedium, TextColor3 = C.accentDim,
        })
        _vw = frame(_wi, "Options", 0, 22, 0, 0)
        _vw.Size = UDim2.new(1, 0, 0, 0)
        _vw.BackgroundTransparency = 1
        _vw.AutomaticSize = Enum.AutomaticSize.Y
        _ux("UIListLayout", {
            Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder,
        }, _vw)
        _vx = 0
    end

    local function _wj(label, getter, setter)
        _vx = _vx + 1
        local control = _vb(_vw, {
            Name = label, Size = UDim2.new(1, 0, 0, 32), LayoutOrder = _vx,
        })
        _va(control, label, 11, {
            Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -82, 1, 0),
        })
        local state = _va(control, "", 9, {
            Name = "Value", Position = UDim2.new(1, -69, 0, 0),
            Size = UDim2.fromOffset(30, 32), TextXAlignment = Enum.TextXAlignment.Right,
        })
                                                                                                     
        local box = frame(control, "Checkbox", 0, 7, 18, 18, C.control)
        box.Position = UDim2.new(1, -30, 0, 7)
        local border = _uz(box, C.accentDim)
        local _wk = frame(box, "Check", 0, 0, 18, 18)
        _wk.BackgroundTransparency = 1
        local _wl = frame(_wk, "Short", 3, 9, 6, 2, C.background)
        _wl.Rotation = 45
        local _wm = frame(_wk, "Long", 6, 7, 9, 2, C.background)
        _wm.Rotation = -45
        local previous = nil
        local function refresh(_ai)
            local _wn = getter() == true
            if _wn == previous then return end
            previous = _wn
            state.Text = _wn and "ON" or "OFF"
            border.Transparency = _wn and 1 or 0
            _vz(state, { TextColor3 = _wn and C.accent or C.muted }, _ai)
            _vz(_wl, { BackgroundTransparency = _wn and 0 or 1 }, _ai)
            _vz(_wm, { BackgroundTransparency = _wn and 0 or 1 }, _ai)
            _vz(box, { BackgroundColor3 = _wn and C.accent or C.control }, _ai)
        end
        _wc(control)
        _ac(control.Activated, function()
            if not S.alive then return end
            _wf()
            setter(not getter())
            refresh(false)
        end)
        refresh(true)
        table.insert(_vo, function() refresh(false) end)
    end

    local function _wo(label, choices, getter, setter)
        _vx = _vx + 1
        local _wp = _vw
        local _wq = frame(_wp, label, 0, 0, 0, 34)
        _wq.BackgroundTransparency = 1
        _wq.Size = UDim2.new(1, 0, 0, 34)
        _wq.LayoutOrder = _vx
        _wq.ClipsDescendants = true
        _va(_wq, label, 11, {
            Position = UDim2.fromOffset(12, 0), Size = UDim2.fromOffset(110, 34),
            TextColor3 = C.muted,
        })
        local _wr = _vb(_wq, {
            Name = "Select", Position = UDim2.fromOffset(128, 2),
            Size = UDim2.new(1, -128, 0, 30),
        })
        _uz(_wr)
        local selected = _va(_wr, "", 11, {
            Name = "SelectedValue", Position = UDim2.fromOffset(12, 0),
            Size = UDim2.new(1, -45, 1, 0),
        })
        local _ws = frame(_wr, "Arrow", 0, 9, 12, 12)
        _ws.Position = UDim2.new(1, -27, 0, 9)
        _ws.BackgroundTransparency = 1
        frame(_ws, "Left", 1, 5, 6, 2, C.accent).Rotation = 45
        frame(_ws, "Right", 5, 5, 6, 2, C.accent).Rotation = -45
        local _wt = #choices * 32 - 4
        local _wu = frame(_wq, "Choices", 0, 38, 0, _wt)
        _wu.Size = UDim2.new(1, 0, 0, _wt)
        _wu.BackgroundTransparency = 1
        _wu.Visible = false
        _ux("UIListLayout", {
            Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
        }, _wu)
        local entry = { row = _wq, menu = _wu, arrow = _ws, body = _wp, open = false }
        local _wv = {}
        entry.setOpen = function(open, _ai)
            entry.open = open
            if open then _wu.Visible = true end
            for _, _um in ipairs(_wv) do
                _um.button.Interactable = open
                if not open then _um.reset() end
            end
            _vz(_ws, { Rotation = open and 180 or 0 }, _ai, 0.18)
            _vz(_wq, { Size = UDim2.new(1, 0, 0, open and (42 + _wt) or 34) },
                _ai, open and 0.18 or 0.14, function()
                    if not entry.open then
                        _wu.Visible = false
                                                                                            
                    end
                end)
        end
        table.insert(_vr, entry)
        local _ww = nil
        local function refresh(_ai)
            local value = getter()
            if value == _ww then return end
            _ww = value
            for _, _um in ipairs(_wv) do
                local active = value == _um.value
                if active then selected.Text = _um.label end
                _um.button.Text = (active and "  >  " or "      ") .. _um.label
                _um.button.TextColor3 = active and C.accent or C.text
                _um.repaint(_ai)
            end
        end
        for index, choice in ipairs(choices) do
            local _wx = _vb(_wu, {
                Name = choice.value, TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2.new(1, 0, 0, 28), LayoutOrder = index,
                Interactable = false,
            })
            local repaint, reset = _wc(_wx, function()
                return getter() == choice.value and C.active or C.control
            end)
            table.insert(_wv, {
                button = _wx, value = choice.value, label = choice.label,
                repaint = repaint, reset = reset,
            })
            _ac(_wx.Activated, function()
                if not S.alive or _vs ~= entry then return end
                setter(choice.value)
                refresh()
                _wf()
            end)
        end
        _wc(_wr)
        _ac(_wr.Activated, function()
            if not S.alive then return end
            local _wy = _vs == entry
            _wf(not _wy)
            if not _wy then
                _vs = entry
                S.uiBusy = true
                entry.setOpen(true, false)
                _ar(true)
            end
        end)
        refresh(true)
        table.insert(_vo, refresh)
    end

                                                                               
    _wh("AUTOMATION")

    _wj(
        "Auto save",
        function()
            return _s.AUTO_GK_ENABLED
        end,
        _uv
    )

    _wj(
        "Close-range rush",

        function()
            return _aa.CloseRangeRush
        end,

        function(value)
            _aa.CloseRangeRush = value
            _gp.candidate = nil
        end
    )

    _wj(
        "High-ball jumps",

        function()
            return _aa.HighBallJumps
        end,

        function(value)
            _aa.HighBallJumps = value
        end
    )

    _wj(
        "Jump then dive",

        function()
            return _aa.JumpThenDive
        end,

        function(value)
            _aa.JumpThenDive = value
        end
    )

    _wo(
        "Dive direction",

        {
            { value = "SMART", label = "Smart" },
            { value = "FORWARD", label = "Forward" },
            { value = "LEFT", label = "Left" },
            { value = "RIGHT", label = "Right" },
            { value = "SIDES", label = "Sides" },
        },

        function()
            return _aa.DiveFilter == "ALL"
                and "SMART"
                or _aa.DiveFilter
        end,

        function(value)
            _aa.DiveFilter = value
        end
    )

    _wj(
        "Lob / back recovery",

        function()
            return _aa.BackwardRecovery
        end,

        function(value)
            _aa.BackwardRecovery = value
        end
    )

    _wh("POSITIONING")

    _wj(
        "Position assist",

        function()
            return _aa.PositionAssist
        end,

        function(value)
            _aa.PositionAssist = value

            if not value then
                _ar(true)
            end
        end
    )

    _wj(
        "Pre-shot coverage",

        function()
            return _aa.PreShotCoverage
        end,

        function(value)
            _aa.PreShotCoverage = value
            _ar(true)
        end
    )

    _wo(
        "Position mode",

        {
            { value = "THREATS", label = "Threats only" },
            {
                value = "HOME_AND_THREATS",
                label = "Home + threats",
            },
        },

        function()
            return _aa.PositionMode
        end,

        function(value)
            _aa.PositionMode = value
            _ar(true)
        end
    )

    _wj(
        "Manual movement first",

        function()
            return _aa.RespectManualMovement
        end,

        function(value)
            _aa.RespectManualMovement = value
        end
    )

    local _wz = #_vo
    local _xa = frame(_vj, "Shooting", 0, 0, 292, 127)
    _xa.BackgroundTransparency = 1
    _va(_xa, "SHOOTING", 9, {
        Position = UDim2.fromOffset(0, 0), Size = UDim2.fromOffset(292, 16),
        Font = Enum.Font.GothamMedium, TextColor3 = C.accentDim,
    })
    _vw = frame(_xa, "Options", 0, 22, 292, 105)
    _vw.BackgroundTransparency = 1
    _ux("UIListLayout", {
        Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder,
    }, _vw)
    _vx = 0
    _wj("Best shot assist", function() return _ut.Enabled end, _ut.SetEnabled)
    _wj("Auto curve ball", function() return _ut.AutoCurve end, _ut.SetAutoCurve)
    _wj("Smart shot release", function() return _ut.SmartRelease end, _ut.SetSmartRelease)
    local _xb = frame(_vj, "Miscellaneous", 0, 141, 292, 89)
    _xb.BackgroundTransparency = 1
    _va(_xb, "MISCELLANEOUS", 9, {
        Position = UDim2.fromOffset(0, 0), Size = UDim2.fromOffset(292, 16),
        Font = Enum.Font.GothamMedium, TextColor3 = C.accentDim,
    })
    _vw = frame(_xb, "Options", 0, 22, 292, 67)
    _vw.BackgroundTransparency = 1
    _ux("UIListLayout", {
        Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder,
    }, _vw)
    _vx = 0
    _wj("Auto dribble", function() return _uu.AutoDribble end, _uu.SetAutoDribble)
    _wj("Infinite stamina", function() return _uu.InfiniteStamina end, _uu.SetInfiniteStamina)
    local _xc = _va(_vj, "OFF", 11, {
        Name = "StrikerStatus", Position = UDim2.fromOffset(8, 240),
        Size = UDim2.fromOffset(276, 30), TextWrapped = true,
        Font = Enum.Font.GothamMedium, TextColor3 = C.accent,
    })
    local _xd = _va(_vj, "", 10, {
        Name = "StrikerDetail", Position = UDim2.fromOffset(8, 274),
        Size = UDim2.fromOffset(276, 54), TextWrapped = true,
        TextColor3 = C.muted,
    })
    local _xe = _va(_vj, "", 9, {
        Name = "MiscStatus", Position = UDim2.fromOffset(8, 331), Size = UDim2.fromOffset(276, 28),
        TextWrapped = true, TextColor3 = C.accentDim,
    })
    _va(_vj, "Shots: within 55 studs. Hold for smart release.\nDribble: nearby opponents within 9 studs.", 10, {
        Position = UDim2.fromOffset(8, 364), Size = UDim2.fromOffset(276, 32),
        TextWrapped = true, TextColor3 = C.muted,
    })

    local _xf, _xg, _xh
    local _xi = nil
    local _xj = nil
    local _xk = nil
    local refresh
    local function _xl()
        local camera = workspace.CurrentCamera
        return camera and camera.ViewportSize or Vector2.new(1280, 720)
    end

    local function _xm(requestedX, requestedY)
        local _xn = _xl()
        local top = math.min(48, _xn.Y * 0.1)
        local width, height = 316, _vu and 40 or 494
        local scale = math.min(1, math.max(1, _xn.X - 32) / width,
            math.max(1, _xn.Y - top - 16) / height)
        if _xn ~= _xi or _vu ~= _xj or _vv ~= _xk then
            _ve.Scale = scale
            panel.Size = UDim2.fromOffset(width, height)
            _vi.Visible = not _vu
            _vn.Visible = not _vu and _vv == "GK"
            _vk.Visible = not _vu and _vv == "GK"
            _vj.Visible = not _vu and _vv == "STR"
            _xi, _xj, lastTab = _xn, _vu, _vv
        end
        local x = math.clamp(requestedX or _vd.Position.X.Offset, 16,
            math.max(16, _xn.X - width * scale - 16))
        local y = math.clamp(requestedY or _vd.Position.Y.Offset, top,
            math.max(top, _xn.Y - height * scale - 16))
        if x ~= _vd.Position.X.Offset or y ~= _vd.Position.Y.Offset then
            _vd.Position = UDim2.fromOffset(x, y)
        end
    end

    _ac(_vg.Activated, function()
        if not S.alive then return end
        _vt = false
        _wf(true)
        _vu = not _vu
        _vg.Text = _vu and "+" or "-"
        _xm()
        if not _vu then refresh() end
    end)
    _ac(_vh.Activated, function()
        if S.alive and type(_s.StopAutoGK) == "function" then _s.StopAutoGK() end
    end)
    _ac(_vf.InputBegan, function(_sl)
        if not S.alive or _vt then return end
        if _sl.UserInputType == Enum.UserInputType.MouseButton1
            or _sl.UserInputType == Enum.UserInputType.Touch then
            _wf(true)
            _vt = true
            S.uiBusy = true
            _xf, _xg, hostStart = _sl, _sl.Position, _vd.Position
            _ar(true)
        end
    end)
    _ac(UserInputService.InputEnded, function(_sl)
        if _sl == _xf or (_xf
            and _xf.UserInputType == Enum.UserInputType.MouseButton1
            and _sl.UserInputType == Enum.UserInputType.MouseButton1) then
            _vt = false
            _xf = nil
            S.uiBusy = _vs ~= nil
        end
    end)
    _ac(UserInputService.InputChanged, function(_sl)
        if not S.alive or not _vt then return end
        if _sl == _xf or (_xf
            and _xf.UserInputType == Enum.UserInputType.MouseButton1
            and _sl.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = _sl.Position - _xg
            _xm(_xh.X.Offset + delta.X, _xh.Y.Offset + delta.Y)
        end
    end)
    _ac(UserInputService.InputBegan, function(_sl, processed)
        if not S.alive then return end
        if _vs and (_sl.UserInputType == Enum.UserInputType.MouseButton1
            or _sl.UserInputType == Enum.UserInputType.Touch)
            and not _wg(_sl.Position, _vs.row) then
            _wf()
        end
        if _sl.KeyCode == Enum.KeyCode.Escape then _wf() end
        if not processed and _sl.KeyCode == Enum.KeyCode.RightShift then
            _vt = false
            _xf = nil
            _wf(true)
            _vc.Enabled = not _vc.Enabled
            if _vc.Enabled then refresh() end
        end
    end)
    _ac(UserInputService.WindowFocusReleased, function()
        _vt = false
        _xf = nil
        _wf(true)
    end)

    local function _xo(object, property, value)
        if object[property] ~= value then object[property] = value end
    end
    refresh = function()
        if not _vc.Enabled or not _vc.Parent then return end
        if _xl() ~= _xi then _xm() end
        if _vu then return end
        if _vv == "STR" then
            for i = _wz + 1, #_vo do _vo[i]() end
            _xo(_xc, "Text", _ut.Status)
            _xo(_xd, "Text", _ut.Detail)
            _xo(_xe, "Text", "Dribble: " .. _uu.DribbleStatus .. " | Stamina: " .. _uu.StaminaStatus)
            return
        end
        for i = 1, _wz do _vo[i]() end
        _af()
        _xo(_vm, "Text", S.displayName)
        _xo(_vl, "BackgroundColor3", S.wasKeeper and _aa.Enabled and _s.AUTO_GK_ENABLED
            and C.accent or C.muted)
    end

    local _xp = {}
    local function _xq(name, x)
        local control = _vb(_vi, {
            Name = name, Position = UDim2.fromOffset(x, 0),
            Size = UDim2.fromOffset(142, 26),
        })
        local label = _va(control, name, 11, {
            Name = "Label", Size = UDim2.fromScale(1, 1),
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Center,
        })
        local border = _uz(control)
        local repaint = _wc(control, function()
            return _vv == name and C.active or C.control
        end)
        local function draw(_ai)
            local selected = _vv == name
            _vz(label, { TextColor3 = selected and C.accent or C.muted }, _ai)
            _vz(border, { Color = selected and C.accentDim or C.stroke }, _ai)
            repaint(_ai)
        end
        table.insert(_xp, draw)
        _ac(control.Activated, function()
            if not S.alive or _vv == name then return end
            _wf(true)
            _vv = name
            for _, redraw in ipairs(_xp) do redraw(false) end
            _xm()
            refresh()
        end)
        draw(true)
    end
    _xq("GK", 0)
    _xq("STR", 150)

    _ac(RunService.Heartbeat, function()
        if not S.alive or not _vc.Enabled or not _vc.Parent then return end
        local clock = os.clock()
        if clock < S.nextUIAt then return end
        S.nextUIAt = clock + 1 / _aa.UISampleHz
        local ok, err = pcall(refresh)
        if not ok then _ae("UI", err) end
    end)
    refresh()
end

                                                                
           
                                                                


_s.__AUTO_GK_CLEANUP = cleanup
_s.StopAutoGK = cleanup

_s.ToggleAutoGK = function(value)
    _uv(
        value == nil and not _s.AUTO_GK_ENABLED
            or value == true
    )
end

_s.AutoGKDebug = function()
    print(
        "[Auto GK] consecutive runtime failures:", S.runtimeFailures,
        "| last runtime error:", S.runtimeError or "none"
    )
    print("[Auto GK] cleanup:", S.cleanupComplete == true,
        "| last cleanup error:", S.cleanupError or "none")

    print(
        "[Auto GK] name:", _r,
        "| alive:", S.alive,
        "| effective enabled:",
        S.alive and _aa.Enabled and _s.AUTO_GK_ENABLED
    )

    print(
        "[Auto GK] focus:", S.focused,
        "| UI busy:", S.uiBusy
    )

    print(
        "[Auto GK] sender error:",
        S.transportError or "none"
    )

    print(
        "[Auto GK] raw:", S.status, S.detail,
        "| display:", S.displayName
    )

    print(
        "[Auto GK] actions:", _ab.Requests,
        "| jumps:", _ab.JumpRequests,
        "| dives:", _ab.DiveRequests,
        "| distinct flights acted on:", _ab.FlightsActedOn
    )

    print(
        "[Auto GK] pre-shot coverage:", _aa.PreShotCoverage,
        "| movement writes:", S.coverageWrites
    )

    print(
        "[Auto GK] planner:", S.lastPlanReason,
        "| immediate directions:", S.immediatePlansChecked,
        "| delayed candidates:", S.delayedPlansChecked,
        "| milliseconds:", S.plannerMilliseconds
    )

    print(
        "[Auto GK] close-range rush:", _aa.CloseRangeRush,
        "| requests:", _ab.RushRequests,
        "| native controller owns rush recovery"
    )

    print(
        "[Auto GK] own lock acquisitions:", S.ownLockAcquires,
        "| releases:", S.ownLockReleases,
        "| current lease:",
        S.motionLease and S.motionLease.id or "none"
    )

    print(
        "[Auto GK] ball:", S.ballPhase,
        "|", S.ballInfo,
        "| id:", S.observedBallId
    )

    print(
        "[Auto GK] position:", _aa.PositionMode,
        "| allowed:", S.allowPositioning,
        "| active:", S.positionActive,
        "| movement writes:", S.positionWrites,
        "| releases:", S.releaseWrites
    )

    print(
        "[Auto GK] frame age:",
        S.lastFrame and os.clock() - S.lastFrame.readClock or "none",
        "| jump delay estimate:", S.queueEstimate
    )

    print(
        "[Auto GK] HOLD:",
        "movement stops", S.holdStops,
        "| fresh checks", S.holdRechecks,
        "| checks without contact", S.holdRecheckMisses,
        "| follow-ups blocked", S.followupBlocks
    )

    local _xr = {}

    for name, count in pairs(S.releaseReasons) do
        _xr[#_xr + 1] =
            name .. "=" .. tostring(count)
    end

    table.sort(_xr)

    print(
        "[Auto GK] movement release reasons:",
        table.concat(_xr, ", "),
        "| last:", S.lastReleaseReason
    )

    if _p.Character then
        local character = _p.Character
        local root = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        local _xs, suspended = pcall(
            M.Controllers.IsSuspended,
            character
        )

        local _xu, diveActive = pcall(
            M.Dive.IsDiveConstraintActive,
            root
        )

        local _xw, slideActive =
            pcall(M.Slide.IsSlideTackling)

        local _xy, dodgeActive =
            pcall(M.Dodge.IsDribbling)

        print(
            "[Auto GK] controller checks:",
            "suspended",
            _xs and tostring(_xt) or "unavailable",
            "| dive rig",
            _xu and tostring(_xv) or "unavailable",
            "| slide",
            _xw and tostring(_xx) or "unavailable",
            "| dodge",
            _xy and tostring(_xz) or "unavailable"
        )

        if humanoid then
            print(
                "[Auto GK] humanoid:",
                humanoid:GetState().Name,
                "| speed", humanoid.WalkSpeed,
                "| jump height", humanoid.JumpHeight
            )
        end

        print(
            "[Auto GK] movement blocks:",
            table.concat(
                M.Movement.GetZeroWalkSpeedSources(),
                ", "
            )
        )

        for _, name in ipairs({
            "GoalkeeperDive",
            "SlideTackle",
            "TackleKick",
            "ItemBallControls",
        }) do
            local ok, value = pcall(
                M.Locks.IsLocked,
                _p,
                name
            )

            print(
                "[Auto GK] game lock",
                name,
                ok and tostring(value) or "unavailable"
            )
        end
    end
end

print("[Auto GK] Loaded | RightShift: show / hide")

               
end)
