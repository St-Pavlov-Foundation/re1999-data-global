module("modules.logic.sp01.odyssey.controller.OdysseyStatHelper", package.seeall)

local var_0_0 = class("OdysseyStatHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0.sceneStartTime = 0
	arg_1_0.dungeonStartTime = 0
	arg_1_0.viewStartTime = 0
end

function var_0_0.initSceneStartTime(arg_2_0)
	arg_2_0.sceneStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.initViewStartTime(arg_3_0)
	arg_3_0.viewStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.initDungeonStartTime(arg_4_0)
	arg_4_0.dungeonStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.sendOdysseyDungeonViewClickBtn(arg_5_0, arg_5_1)
	StatController.instance:track(StatEnum.EventName.S01OdysseyDungeonBtnClick, {
		[StatEnum.EventProperties.Odyssey_MapId] = tostring(OdysseyDungeonModel.instance:getCurMapId()),
		[StatEnum.EventProperties.Odyssey_ButtonName] = arg_5_1,
		[StatEnum.EventProperties.Odyssey_InterfaceName] = "OdysseyDungeonView"
	})
end

function var_0_0.sendOdysseyDungeonViewClose(arg_6_0, arg_6_1, arg_6_2)
	StatController.instance:track(StatEnum.EventName.S01OdysseyDungeonViewClose, {
		[StatEnum.EventProperties.Odyssey_InterfaceName] = "OdysseyDungeonSceneView",
		[StatEnum.EventProperties.Odyssey_MapId] = tostring(arg_6_1),
		[StatEnum.EventProperties.Odyssey_OperationType] = arg_6_2,
		[StatEnum.EventProperties.Odyssey_Usetime] = UnityEngine.Time.realtimeSinceStartup - arg_6_0.sceneStartTime
	})
end

function var_0_0.sendOdysseyViewStayTime(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1 == "OdysseyDungeonView"

	StatController.instance:track(StatEnum.EventName.S01OdysseyViewStayTime, {
		[StatEnum.EventProperties.Odyssey_InterfaceName] = arg_7_1,
		[StatEnum.EventProperties.Odyssey_ActAssassinLibraryId] = arg_7_2 and arg_7_2 or 0,
		[StatEnum.EventProperties.Odyssey_Usetime] = UnityEngine.Time.realtimeSinceStartup - (var_7_0 and arg_7_0.dungeonStartTime or arg_7_0.viewStartTime)
	})
end

function var_0_0.sendLibraryDialogueClick(arg_8_0, arg_8_1)
	StatController.instance:track(StatEnum.EventName.S01LibraryDetailViewClick, {
		[StatEnum.EventProperties.Odyssey_InterfaceName] = "AssassinLibraryDetailView",
		[StatEnum.EventProperties.Odyssey_ButtonName] = arg_8_1
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
