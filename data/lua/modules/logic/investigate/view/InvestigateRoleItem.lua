module("modules.logic.investigate.view.InvestigateRoleItem", package.seeall)

local var_0_0 = class("InvestigateRoleItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0.viewGO, "role")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "locked")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "clickarea")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "progress")
	arg_1_0._goprogresitem = gohelper.findChild(arg_1_0.viewGO, "progress/item")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = arg_4_0._mo
	})
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._gounlockEffect = gohelper.findChild(arg_5_0.viewGO, "#unlock")

	arg_5_0:addEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, arg_5_0._onLinkedOpinionSuccess, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_5_0._onCloseViewCall, arg_5_0)
end

function var_0_0._onCloseViewCall(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.InvestigateOpinionTabView then
		-- block empty
	end
end

function var_0_0._isShowRedDot(arg_7_0)
	return arg_7_0._isUnlocked and InvestigateController.showInfoRedDot(arg_7_0._mo.id)
end

function var_0_0._onLinkedOpinionSuccess(arg_8_0)
	arg_8_0:_updateProgress()
end

function var_0_0._editableAddEvents(arg_9_0)
	return
end

function var_0_0._editableRemoveEvents(arg_10_0)
	return
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0._mo = arg_11_1
	arg_11_0._isUnlocked = arg_11_1.episode == 0 or DungeonModel.instance:hasPassLevel(arg_11_1.episode)

	gohelper.setActive(arg_11_0._simagerole, arg_11_0._isUnlocked)
	gohelper.setActive(arg_11_0._golocked, not arg_11_0._isUnlocked)

	if arg_11_0._isUnlocked and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, arg_11_0._mo.id) then
		gohelper.setActive(arg_11_0._gounlockEffect, arg_11_0._isUnlocked)
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, arg_11_0._mo.id)
	end

	if arg_11_0._isUnlocked then
		arg_11_0._simagerole:LoadImage(arg_11_1.icon)
	end

	arg_11_0:_initOpinionProgress()
end

function var_0_0._initOpinionProgress(arg_12_0)
	arg_12_0._progressItemList = arg_12_0:getUserDataTb_()

	local var_12_0 = InvestigateConfig.instance:getInvestigateRelatedClueInfos(arg_12_0._mo.id)

	gohelper.CreateObjList(arg_12_0, arg_12_0._onItemShow, var_12_0, arg_12_0._goprogress, arg_12_0._goprogresitem)
	arg_12_0:_updateProgress()
end

function var_0_0._onItemShow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getUserDataTb_()

	arg_13_0._progressItemList[arg_13_3] = var_13_0
	var_13_0.unfinished = gohelper.findChild(arg_13_1, "unfinished")
	var_13_0.finished = gohelper.findChild(arg_13_1, "finished")
	var_13_0.light = gohelper.findChild(arg_13_1, "light")
	var_13_0.reddot = gohelper.findChild(arg_13_1, "reddot")
	var_13_0.config = arg_13_2
end

function var_0_0._updateProgress(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._progressItemList) do
		local var_14_0 = iter_14_1.config.id
		local var_14_1 = InvestigateOpinionModel.instance:getLinkedStatus(var_14_0)

		gohelper.setActive(iter_14_1.unfinished, not var_14_1)
		gohelper.setActive(iter_14_1.finished, var_14_1)

		local var_14_2 = InvestigateOpinionModel.instance:isUnlocked(var_14_0) and arg_14_0._isUnlocked

		gohelper.setActive(iter_14_1.reddot, var_14_2 and not var_14_1)
	end
end

function var_0_0.onSelect(arg_15_0, arg_15_1)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
