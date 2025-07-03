module("modules.logic.versionactivity2_7.coopergarland.define.CooperGarlandEnum", package.seeall)

local var_0_0 = _M

var_0_0.Const = {
	TaskMOAllFinishId = -99999,
	BallPosOffset = -0.06,
	SpikeMoveDirX = 1,
	PanelPosZ = -0.6,
	JoystickModeLeft = 3,
	JoystickModeRight = 1,
	DefaultGameProgress = "1",
	SpikeMoveDirY = 2,
	CameraMaxFov = 120,
	GyroscopeMode = 2
}
var_0_0.ComponentType = {
	Key = 5,
	End = 2,
	Door = 4,
	Story = 8,
	Wall = 3,
	Hole = 6,
	Start = 1,
	Spike = 7
}
var_0_0.ConstId = {
	Gravity = 1,
	BallScale = 8,
	BallAngularDrag = 10,
	SpikeMoveSpeed = 7,
	CubeBalanceRestSpeed = 11,
	CubeMaxAngle = 6,
	GyroSensitivity = 9,
	CubePos = 5,
	CameraPosZ = 3,
	CameraFOV = 4,
	BallDrag = 2
}
var_0_0.BlockKey = {
	LoadGameScene = "CooperGarlandLoadGameSceneBlockKey",
	LoadGameRes = "CooperGarlandLoadGameResBlockKey",
	OneClickClaimReward = "CooperGarlandOneClickClaimRewardBlockKey"
}
var_0_0.ResPath = {
	Ball = "scenes/v2a7_m_s12_kbhh_jshd/prefab/v2a7_m_s12_kbhh_jshd_ball_p.prefab",
	UIPanel = "ui/viewres/versionactivity_2_7/v2a7_coopergarland/map/panel.prefab"
}

return var_0_0
