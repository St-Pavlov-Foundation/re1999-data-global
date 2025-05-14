module("modules.logic.equip.view.EquipTeamShowView", package.seeall)

local var_0_0 = class("EquipTeamShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnCloseEquipTeamShowView, arg_2_0._closeThisView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0._targetEquipUid, arg_4_0._inTeam = EquipTeamListModel.instance:getTeamEquip()[1], true

	arg_4_0:_refreshUI()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, false)
end

function var_0_0._closeThisView(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0._targetEquipUid = arg_7_0.viewParam[1]
	arg_7_0._inTeam = arg_7_0.viewParam[2]

	arg_7_0:_refreshUI()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._showHideItem2 = false
	arg_8_0._lastItem2Uid = nil
	arg_8_0._itemList = arg_8_0._itemList or arg_8_0:getUserDataTb_()
	arg_8_0._itemTipList = arg_8_0._itemTipList or arg_8_0:getUserDataTb_()
	arg_8_0._targetEquipUid = arg_8_0.viewParam[1]
	arg_8_0._inTeam = arg_8_0.viewParam[2]

	arg_8_0:_refreshUI()
end

var_0_0.TeamShowItemPosList = {
	{
		-134.1,
		23.4
	},
	{
		420,
		23.4
	}
}

function var_0_0._refreshUI(arg_9_0)
	local var_9_0 = EquipTeamListModel.instance:getHero()

	arg_9_0._heroId = var_9_0 and var_9_0.heroId
	arg_9_0._showHideItem2 = false

	local var_9_1 = 2

	if arg_9_0._inTeam then
		arg_9_0:addItem(var_0_0.TeamShowItemPosList[var_9_1][1], var_0_0.TeamShowItemPosList[var_9_1][2], arg_9_0._targetEquipUid, true, nil, 1)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, false)

		return
	end

	local var_9_2 = EquipTeamListModel.instance:getTeamEquip()[1]
	local var_9_3 = var_0_0.TeamShowItemPosList[var_9_1]

	if var_9_2 and EquipModel.instance:getEquip(var_9_2) then
		arg_9_0._showHideItem2 = true

		arg_9_0:addItem(var_9_3[1], var_9_3[2], arg_9_0._targetEquipUid, false, true, 1)

		var_9_1 = var_9_1 - 1

		local var_9_4 = var_0_0.TeamShowItemPosList[var_9_1]

		arg_9_0:addItem(var_9_4[1], var_9_4[2], var_9_2, true, true, 2)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, true)
	else
		arg_9_0:addItem(var_0_0.TeamShowItemPosList[var_9_1][1], var_0_0.TeamShowItemPosList[var_9_1][2], arg_9_0._targetEquipUid, false, false, 1)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, false)
	end

	if arg_9_0.viewContainer.animBgUpdate then
		arg_9_0.viewContainer:animBgUpdate()
	end
end

function var_0_0.addItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes[1]
	local var_10_1 = arg_10_0._itemTipList[arg_10_6]

	if not var_10_1 then
		var_10_1 = arg_10_0:getResInst(var_10_0, arg_10_0.viewGO, "item" .. arg_10_6)

		table.insert(arg_10_0._itemTipList, arg_10_6, var_10_1)
	end

	if arg_10_0._itemTipList[2] then
		gohelper.setActive(arg_10_0._itemTipList[2], arg_10_0._showHideItem2)

		if arg_10_6 == 2 and arg_10_0._lastItem2Uid ~= arg_10_3 then
			gohelper.setActive(arg_10_0._itemTipList[2], false)

			arg_10_0._lastItem2Uid = arg_10_3
		end
	end

	gohelper.setActive(var_10_1, true)
	recthelper.setAnchor(var_10_1.transform, arg_10_1, arg_10_2)

	local var_10_2 = arg_10_0._itemList[arg_10_6]

	if not var_10_2 then
		var_10_2 = EquipTeamShowItem.New()

		table.insert(arg_10_0._itemList, arg_10_6, var_10_2)
		var_10_2:initView(var_10_1, {
			arg_10_3,
			arg_10_4,
			arg_10_5,
			arg_10_0,
			arg_10_0._heroId,
			arg_10_6
		})
	else
		var_10_2.viewParam = {
			arg_10_3,
			arg_10_4,
			arg_10_5,
			arg_10_0,
			arg_10_0._heroId,
			arg_10_6
		}

		var_10_2:onUpdateParam()
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._itemList) do
		iter_12_1:destroyView()
	end
end

return var_0_0
