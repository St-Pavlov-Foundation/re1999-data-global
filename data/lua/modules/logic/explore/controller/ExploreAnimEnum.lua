module("modules.logic.explore.controller.ExploreAnimEnum", package.seeall)

slot0 = _M
slot0.AnimName = {
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
slot0.LoopAnims = {
	[slot0.AnimName.unable] = true,
	[slot0.AnimName.normal] = true,
	[slot0.AnimName.active] = true,
	[slot0.AnimName.active2] = true,
	[slot0.AnimName.count1] = true,
	[slot0.AnimName.count2] = true,
	[slot0.AnimName.count3] = true
}
slot0.AnimHashToName = {}
slot0.AnimNameToHash = {}

for slot4 in pairs(slot0.AnimName) do
	slot5 = UnityEngine.Animator.StringToHash(slot4)
	slot0.AnimHashToName[slot5] = slot4
	slot0.AnimNameToHash[slot4] = slot5
end

slot0.NextAnimName = {
	enter = slot0.AnimName.normal,
	uToN = slot0.AnimName.normal,
	nToU = slot0.AnimName.unable,
	nToA = slot0.AnimName.active,
	aToN = slot0.AnimName.normal,
	exit = slot0.AnimName.exit
}
slot0.RoleAnimName = {
	idle = "idle",
	move = "move_slow"
}
slot0.RoleAnimKey = {
	IsIce = "isIce",
	MoveDir = "moveDir",
	MoveState = "moveState",
	Status = "status"
}
slot0.RoleMoveState = {
	Idle = 0,
	Move = 1
}
slot0.RoleAnimStatus = {
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
slot0.RoleAnimLen = {
	[slot0.RoleAnimStatus.Carry] = 1.067,
	[slot0.RoleAnimStatus.Pull] = 0,
	[slot0.RoleAnimStatus.Fall] = 0,
	[slot0.RoleAnimStatus.Glide] = 0,
	[slot0.RoleAnimStatus.OpenChest] = 1.167,
	[slot0.RoleAnimStatus.CreateUnit] = 2,
	[slot0.RoleAnimStatus.UseItem] = 1.333,
	[slot0.RoleAnimStatus.NoUseItem] = 0.933,
	[slot0.RoleAnimStatus.Entry] = 1.467,
	[slot0.RoleAnimStatus.Interact] = 0.8,
	[slot0.RoleAnimStatus.Fix] = 2.167,
	[slot0.RoleAnimStatus.CarryPick] = 0.8,
	[slot0.RoleAnimStatus.CarryPut] = 0.8,
	[slot0.RoleAnimStatus.Finish] = 1.8,
	[slot0.RoleAnimStatus.RotateInteract] = 0.4
}
slot0.RoleHangPointType = {
	Hand_Right = 2,
	Hand_Left = 1
}
slot0.RoleHangPointPath = {
	[slot0.RoleHangPointType.Hand_Left] = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand/hand_l",
	[slot0.RoleHangPointType.Hand_Right] = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand/hand_r"
}
slot0.UseBatonAnim = {
	[slot0.RoleAnimStatus.OpenChest] = slot0.RoleHangPointType.Hand_Left,
	[slot0.RoleAnimStatus.CreateUnit] = slot0.RoleHangPointType.Hand_Right
}
slot0.RoleSpeed = {
	walk = 0.6,
	run = 0.39
}

return slot0
