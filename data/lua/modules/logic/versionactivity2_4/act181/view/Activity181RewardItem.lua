module("modules.logic.versionactivity2_4.act181.view.Activity181RewardItem", package.seeall)

local var_0_0 = class("Activity181RewardItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goHaveGet = gohelper.findChild(arg_1_1, "#go_haveGet")

	gohelper.setActive(arg_1_1, false)

	arg_1_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_1_1)

	gohelper.setAsLastSibling(arg_1_0._goHaveGet)
end

function var_0_0.setEnable(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0.go, arg_2_1)
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._itemIcon:setInPack(false)
	arg_3_0._itemIcon:setMOValue(arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._itemIcon:isShowName(false)
	arg_3_0._itemIcon:isShowCount(true)
	arg_3_0._itemIcon:isShowEffect(true)
	arg_3_0._itemIcon:setGetMask(arg_3_4)
	arg_3_0._itemIcon:setRecordFarmItem({
		type = arg_3_1,
		id = arg_3_2,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
	gohelper.setActive(arg_3_0._goHaveGet, arg_3_4)
end

return var_0_0
