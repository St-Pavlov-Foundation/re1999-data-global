module("modules.logic.dungeon.view.DungeonRewardTipView", package.seeall)

local var_0_0 = class("DungeonRewardTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "scrollTips/Viewport/Content/#txt_info")
	arg_1_0._gorewardContentItem = gohelper.findChild(arg_1_0.viewGO, "scrollTips/Viewport/Content/#go_rewardContentItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gorewardContentItem, false)

	local var_4_0 = lua_helppage.configDict[10801]

	arg_4_0._txttitle.text = var_4_0.title
	arg_4_0._txtinfo.text = var_4_0.text

	local var_4_1 = var_4_0.iconText
	local var_4_2 = GameUtil.splitString2(var_4_1)

	if not var_4_2 or #var_4_2 == 0 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_2) do
		local var_4_3 = iter_4_1[1]
		local var_4_4 = tonumber(iter_4_1[2])

		arg_4_0:_addReward(var_4_3, var_4_4)
	end
end

function var_0_0._addReward(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = gohelper.cloneInPlace(arg_5_0._gorewardContentItem)

	gohelper.setActive(var_5_0, true)

	gohelper.findChildText(var_5_0, "opentitle").text = arg_5_1

	local var_5_1 = DungeonModel.instance:getEpisodeRewardDisplayList(arg_5_2)
	local var_5_2 = gohelper.findChild(var_5_0, "scroll_reward/Viewport/Content")
	local var_5_3 = gohelper.findChild(var_5_0, "scroll_reward/Viewport/Content/commonitemicon")

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_4 = gohelper.cloneInPlace(var_5_3)

		gohelper.setActive(var_5_4, true)

		local var_5_5 = IconMgr.instance:getCommonPropItemIcon(var_5_4)

		var_5_5:setMOValue(iter_5_1[1], iter_5_1[2], iter_5_1[3])
		var_5_5:hideEquipLvAndBreak(true)
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
