module("modules.logic.explore.view.ExploreBonusRewardItem", package.seeall)

local var_0_0 = class("ExploreBonusRewardItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._num = gohelper.findChildText(arg_1_1, "label/#txt_num")
	arg_1_0._lightIcon = gohelper.findChild(arg_1_1, "label/icon_light")
	arg_1_0._normalIcon = gohelper.findChild(arg_1_1, "label/icon_normal")
	arg_1_0._rewardItem = gohelper.findChild(arg_1_1, "go_rewarditem")
	arg_1_0._itemParent = gohelper.findChild(arg_1_1, "label/icons")
	arg_1_0._goline = gohelper.findChild(arg_1_1, "label/line1")
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._num.text = string.format("%02d", arg_4_0._index)

	local var_4_0 = lua_explore_scene.configDict[arg_4_1.chapterId][arg_4_1.episodeId]

	arg_4_0._isGet = ExploreSimpleModel.instance:getBonusIsGet(var_4_0.id, arg_4_1.id)

	ZProj.UGUIHelper.SetColorAlpha(arg_4_0._num, arg_4_0._isGet and 0.3 or 1)
	gohelper.setActive(arg_4_0._lightIcon, arg_4_0._isGet)
	gohelper.setActive(arg_4_0._normalIcon, not arg_4_0._isGet)

	local var_4_1 = GameUtil.splitString2(arg_4_1.bonus, true)

	arg_4_0._items = arg_4_0._items or {}

	gohelper.CreateObjList(arg_4_0, arg_4_0._setRewardItem, var_4_1, arg_4_0._itemParent, arg_4_0._rewardItem)
	gohelper.setActive(arg_4_0._goline, #ExploreTaskModel.instance:getTaskList(0):getList() ~= arg_4_0._index)
end

function var_0_0._setRewardItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._items[arg_5_3] = arg_5_0._items[arg_5_3] or {}

	local var_5_0 = gohelper.findChild(arg_5_1, "go_icon")
	local var_5_1 = gohelper.findChild(arg_5_1, "go_receive")
	local var_5_2 = arg_5_0._items[arg_5_3].item or IconMgr.instance:getCommonPropItemIcon(var_5_0)

	arg_5_0._items[arg_5_3].item = var_5_2

	var_5_2:setMOValue(arg_5_2[1], arg_5_2[2], arg_5_2[3], nil, true)
	var_5_2:setCountFontSize(46)
	var_5_2:SetCountBgHeight(31)
	gohelper.setActive(var_5_1, arg_5_0._isGet)
end

function var_0_0.onDestroyView(arg_6_0)
	for iter_6_0 = 1, #arg_6_0._items do
		arg_6_0._items[iter_6_0].item:onDestroy()
	end
end

return var_0_0
