module("modules.logic.explore.controller.ExploreAnimEnum", package.seeall)

local var_0_0 = _M

var_0_0.AnimName = {
	unable = "unable",
	nToA = "nToA",
	count3to4 = "count3to4",
	count3 = "count3",
	uToN = "uToN",
	count1to2 = "count1to2",
	nToU = "nToU",
	count2 = "count2",
	count0to1 = "count0to1",
	count4to3 = "count4to3",
	count3to2 = "count3to2",
	count2to1 = "count2to1",
	aToN = "aToN",
	active2 = "active2",
	enter = "enter",
	normal = "normal",
	count2to3 = "count2to3",
	exit = "exit",
	count1 = "count1",
	count1to0 = "count1to0",
	active = "active"
}
var_0_0.LoopAnims = {
	[var_0_0.AnimName.unable] = true,
	[var_0_0.AnimName.normal] = true,
	[var_0_0.AnimName.active] = true,
	[var_0_0.AnimName.active2] = true,
	[var_0_0.AnimName.count1] = true,
	[var_0_0.AnimName.count2] = true,
	[var_0_0.AnimName.count3] = true
}
var_0_0.AnimHashToName = {}
var_0_0.AnimNameToHash = {}

for iter_0_0 in pairs(var_0_0.AnimName) do
	local var_0_1 = UnityEngine.Animator.StringToHash(iter_0_0)

	var_0_0.AnimHashToName[var_0_1] = iter_0_0
	var_0_0.AnimNameToHash[iter_0_0] = var_0_1
end

var_0_0.NextAnimName = {
	enter = var_0_0.AnimName.normal,
	uToN = var_0_0.AnimName.normal,
	nToU = var_0_0.AnimName.unable,
	nToA = var_0_0.AnimName.active,
	aToN = var_0_0.AnimName.normal,
	exit = var_0_0.AnimName.exit
}
var_0_0.RoleAnimName = {
	idle = "idle",
	move = "move_slow"
}
var_0_0.RoleAnimKey = {
	IsIce = "isIce",
	MoveDir = "moveDir",
	MoveState = "moveState",
	Status = "status"
}
var_0_0.RoleMoveState = {
	Idle = 0,
	Move = 1
}
var_0_0.RoleAnimStatus = {
	MoveBack = 14,
	CreateUnit = 6,
	Fix = 11,
	Pull = 2,
	CarryPick = 12,
	Interact = 10,
	Carry = 1,
	RotateInteract = 16,
	Finish = 15,
	UseItem = 7,
	Glide = 4,
	Entry = 9,
	NoUseItem = 8,
	Fall = 3,
	OpenChest = 5,
	CarryPut = 13,
	None = 0
}
var_0_0.RoleAnimLen = {
	[var_0_0.RoleAnimStatus.Carry] = 1.067,
	[var_0_0.RoleAnimStatus.Pull] = 0,
	[var_0_0.RoleAnimStatus.Fall] = 0,
	[var_0_0.RoleAnimStatus.Glide] = 0,
	[var_0_0.RoleAnimStatus.OpenChest] = 1.167,
	[var_0_0.RoleAnimStatus.CreateUnit] = 2,
	[var_0_0.RoleAnimStatus.UseItem] = 1.333,
	[var_0_0.RoleAnimStatus.NoUseItem] = 0.933,
	[var_0_0.RoleAnimStatus.Entry] = 1.467,
	[var_0_0.RoleAnimStatus.Interact] = 0.8,
	[var_0_0.RoleAnimStatus.Fix] = 2.167,
	[var_0_0.RoleAnimStatus.CarryPick] = 0.8,
	[var_0_0.RoleAnimStatus.CarryPut] = 0.8,
	[var_0_0.RoleAnimStatus.Finish] = 1.8,
	[var_0_0.RoleAnimStatus.RotateInteract] = 0.4
}
var_0_0.RoleHangPointType = {
	Hand_Right = 2,
	Hand_Left = 1
}
var_0_0.RoleHangPointPath = {
	[var_0_0.RoleHangPointType.Hand_Left] = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand/hand_l",
	[var_0_0.RoleHangPointType.Hand_Right] = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand/hand_r"
}
var_0_0.UseBatonAnim = {
	[var_0_0.RoleAnimStatus.OpenChest] = var_0_0.RoleHangPointType.Hand_Left,
	[var_0_0.RoleAnimStatus.CreateUnit] = var_0_0.RoleHangPointType.Hand_Right
}
var_0_0.RoleSpeed = {
	walk = 0.6,
	run = 0.39
}

return var_0_0
