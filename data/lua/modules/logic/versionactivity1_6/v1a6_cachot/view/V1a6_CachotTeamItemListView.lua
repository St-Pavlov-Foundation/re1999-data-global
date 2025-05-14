module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamItemListView", package.seeall)

local var_0_0 = class("V1a6_CachotTeamItemListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopresetcontent = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/left/scroll_view/Viewport/#go_presetcontent")
	arg_1_0._gopreparecontent = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/right/scroll_view/Viewport/#go_preparecontent")

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
	return
end

function var_0_0._initPresetItemList(arg_5_0)
	if arg_5_0._presetItemList then
		return
	end

	arg_5_0._presetItemList = arg_5_0:getUserDataTb_()

	local var_5_0 = arg_5_0.viewContainer:getSetting().otherRes[1]

	for iter_5_0 = 1, V1a6_CachotEnum.HeroCountInGroup do
		local var_5_1 = arg_5_0:getResInst(var_5_0, arg_5_0._gopresetcontent, "item" .. tostring(iter_5_0))
		local var_5_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_1, V1a6_CachotTeamItem)

		arg_5_0._presetItemList[iter_5_0] = var_5_2

		var_5_2:setInteractable(arg_5_0._isInitSelect)
		var_5_2:setHpVisible(not arg_5_0._isInitSelect)
	end
end

function var_0_0._initPrepareItemList(arg_6_0)
	if arg_6_0._prepareItemList then
		return
	end

	arg_6_0._prepareItemList = arg_6_0:getUserDataTb_()

	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[2]
	local var_6_1 = V1a6_CachotTeamModel.instance:getPrepareNum()

	for iter_6_0 = 1, 4 do
		local var_6_2 = arg_6_0:getResInst(var_6_0, arg_6_0._gopreparecontent, "item" .. tostring(iter_6_0))
		local var_6_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, V1a6_CachotTeamPrepareItem)

		arg_6_0._prepareItemList[iter_6_0] = var_6_3

		var_6_3:setInteractable(arg_6_0._isInitSelect and iter_6_0 <= var_6_1)
		var_6_3:setHpVisible(not arg_6_0._isInitSelect)

		if var_6_1 < iter_6_0 then
			var_6_3:showNone()
		end
	end
end

function var_0_0._initParams(arg_7_0)
	arg_7_0._isInitSelect = arg_7_0.viewParam and arg_7_0.viewParam.isInitSelect
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:_initParams()

	if arg_8_0._isInitSelect then
		arg_8_0:_initModel()
	end

	arg_8_0:_initPresetItemList()
	arg_8_0:_initPrepareItemList()
	arg_8_0:_updatePresetAndPrepare()
	arg_8_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_8_0._modifyHeroGroup, arg_8_0)
end

function var_0_0._modifyHeroGroup(arg_9_0)
	arg_9_0._isModify = true

	arg_9_0:_updatePresetAndPrepare()

	arg_9_0._isModify = false
end

function var_0_0._updatePresetAndPrepare(arg_10_0)
	V1a6_CachotTeamModel.instance:clearSeatInfos()
	arg_10_0:_updatePresetItemList()
	arg_10_0:_updatePrepareItemList()
end

function var_0_0._initModel(arg_11_0)
	local var_11_0 = V1a6_CachotTeamModel.instance:getPrepareNum()
	local var_11_1, var_11_2 = V1a6_CachotModel.instance:getRogueStateInfo():getLastGroupInfo(var_11_0)
	local var_11_3 = V1a6_CachotHeroGroupMO.New()

	var_11_3:setMaxHeroCount(V1a6_CachotEnum.InitTeamMaxHeroCountInGroup)

	local var_11_4 = 1

	var_11_3:init({
		groupId = var_11_4,
		heroList = var_11_1,
		equips = var_11_2
	})
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.InitTeamMaxHeroCountInGroup)
	V1a6_CachotHeroSingleGroupModel.instance:setSingleGroup(var_11_3)
end

function var_0_0._updatePresetItemList(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._presetItemList) do
		local var_12_0 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_12_0)

		V1a6_CachotTeamModel.instance:setSeatInfo(iter_12_0, V1a6_CachotTeamModel.instance:getInitSeatLevel(iter_12_0), var_12_0)

		local var_12_1 = var_12_0:getHeroMO()

		if arg_12_0._isModify and var_12_1 and iter_12_1:getHeroMo() ~= var_12_1 then
			iter_12_1:showSelectEffect()
		end

		iter_12_1:onUpdateMO(var_12_0)
	end
end

function var_0_0._updatePrepareItemList(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._prepareItemList) do
		local var_13_0 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_13_0 + V1a6_CachotEnum.HeroCountInGroup)
		local var_13_1 = var_13_0:getHeroMO()

		if arg_13_0._isModify and var_13_1 and iter_13_1:getHeroMo() ~= var_13_1 then
			iter_13_1:showSelectEffect()
		end

		iter_13_1:onUpdateMO(var_13_0)
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
