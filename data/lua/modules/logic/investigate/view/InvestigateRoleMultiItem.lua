module("modules.logic.investigate.view.InvestigateRoleMultiItem", package.seeall)

local var_0_0 = class("InvestigateRoleMultiItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0.viewGO, "role")
	arg_1_0._btn1click = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "role_1/click")
	arg_1_0._btn2click = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "role_2/click")
	arg_1_0._btn3click = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "role_3/click")
	arg_1_0._btnallclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fullimg/click")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "progress")
	arg_1_0._goprogresitem = gohelper.findChild(arg_1_0.viewGO, "progress/item")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btn1click:AddClickListener(arg_2_0._btnclick1OnClick, arg_2_0)
	arg_2_0._btn2click:AddClickListener(arg_2_0._btnclick2OnClick, arg_2_0)
	arg_2_0._btn3click:AddClickListener(arg_2_0._btnclick3OnClick, arg_2_0)
	arg_2_0._btnallclick:AddClickListener(arg_2_0._btnclickallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btn1click:RemoveClickListener()
	arg_3_0._btn2click:RemoveClickListener()
	arg_3_0._btn3click:RemoveClickListener()
	arg_3_0._btnallclick:RemoveClickListener()
end

function var_0_0._btnclickallOnClick(arg_4_0)
	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = arg_4_0._moList[1],
		moList = arg_4_0._moList
	})
end

function var_0_0._btnclick3OnClick(arg_5_0)
	if not arg_5_0._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = arg_5_0._moList[3],
		moList = arg_5_0._moList
	})
end

function var_0_0._btnclick2OnClick(arg_6_0)
	if not arg_6_0._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = arg_6_0._moList[2],
		moList = arg_6_0._moList
	})
end

function var_0_0._btnclick1OnClick(arg_7_0)
	if not arg_7_0._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = arg_7_0._moList[1],
		moList = arg_7_0._moList
	})
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._gofullimg = gohelper.findChild(arg_8_0.viewGO, "#go_fullimg")
	arg_8_0._goUnFinishedBg = gohelper.findChild(arg_8_0.viewGO, "#simage_bg")

	arg_8_0:addEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, arg_8_0._onLinkedOpinionSuccess, arg_8_0)

	arg_8_0._gounlock1 = gohelper.findChild(arg_8_0.viewGO, "#unlock1")
	arg_8_0._gounlock2 = gohelper.findChild(arg_8_0.viewGO, "#unlock2")
	arg_8_0._gounlock3 = gohelper.findChild(arg_8_0.viewGO, "#unlock3")

	gohelper.setActive(arg_8_0._gounlock1, false)
	gohelper.setActive(arg_8_0._gounlock2, false)
	gohelper.setActive(arg_8_0._gounlock3, false)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0._onCloseViewCall, arg_8_0)
end

function var_0_0._onCloseViewCall(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.InvestigateOpinionTabView then
		-- block empty
	end
end

function var_0_0._isShowRedDot(arg_10_0)
	return arg_10_0._isUnlocked and InvestigateController.showInfoRedDot(arg_10_0._mo.id)
end

function var_0_0._onLinkedOpinionSuccess(arg_11_0)
	arg_11_0:_initOpinionProgress()
	arg_11_0:_checkFinish()
end

function var_0_0._editableAddEvents(arg_12_0)
	return
end

function var_0_0._editableRemoveEvents(arg_13_0)
	return
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0._moList = arg_14_1

	arg_14_0:_checkFinish()

	if not arg_14_0._roleList then
		arg_14_0._roleList = arg_14_0:getUserDataTb_()

		for iter_14_0 = 1, #arg_14_1 do
			local var_14_0 = gohelper.findChildSingleImage(arg_14_0.viewGO, string.format("role_%s", iter_14_0))
			local var_14_1 = gohelper.findChild(arg_14_0.viewGO, string.format("role_%s_locked", iter_14_0))

			arg_14_0._roleList[iter_14_0] = {
				role = var_14_0,
				lock = var_14_1
			}
		end
	end

	for iter_14_1, iter_14_2 in ipairs(arg_14_1) do
		local var_14_2 = arg_14_0._roleList[iter_14_1]
		local var_14_3 = iter_14_2.episode == 0 or DungeonModel.instance:hasPassLevel(iter_14_2.episode)

		gohelper.setActive(var_14_2.role, var_14_3 and not arg_14_0._isAllFinished)
		gohelper.setActive(var_14_2.lock, not var_14_3 and not arg_14_0._isAllFinished)
	end

	arg_14_0._mo = arg_14_1[1]
	arg_14_0._isUnlocked = arg_14_0._mo.episode == 0 or DungeonModel.instance:hasPassLevel(arg_14_0._mo.episode)

	if arg_14_0._isUnlocked and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, arg_14_0._mo.id) and not arg_14_0._isAllFinished then
		gohelper.setActive(arg_14_0._gounlock1, true)
		gohelper.setActive(arg_14_0._gounlock2, true)
		gohelper.setActive(arg_14_0._gounlock3, true)
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, arg_14_0._mo.id)
	end

	arg_14_0:_initOpinionProgress()
end

function var_0_0._initOpinionProgress(arg_15_0)
	arg_15_0._progressItemList = arg_15_0:getUserDataTb_()

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._moList) do
		local var_15_1 = InvestigateConfig.instance:getInvestigateRelatedClueInfos(iter_15_1.id)

		tabletool.addValues(var_15_0, var_15_1)
	end

	gohelper.CreateObjList(arg_15_0, arg_15_0._onItemShow, var_15_0, arg_15_0._goprogress, arg_15_0._goprogresitem)
	arg_15_0:_updateProgress()
end

function var_0_0._onItemShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0:getUserDataTb_()

	arg_16_0._progressItemList[arg_16_3] = var_16_0
	var_16_0.unfinished = gohelper.findChild(arg_16_1, "unfinished")
	var_16_0.finished = gohelper.findChild(arg_16_1, "finished")
	var_16_0.light = gohelper.findChild(arg_16_1, "light")
	var_16_0.reddot = gohelper.findChild(arg_16_1, "reddot")
	var_16_0.config = arg_16_2
end

function var_0_0._updateProgress(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._progressItemList) do
		local var_17_0 = iter_17_1.config.id
		local var_17_1 = InvestigateOpinionModel.instance:getLinkedStatus(var_17_0)

		gohelper.setActive(iter_17_1.unfinished, not var_17_1)
		gohelper.setActive(iter_17_1.finished, var_17_1)

		local var_17_2 = InvestigateOpinionModel.instance:isUnlocked(var_17_0) and arg_17_0._isUnlocked

		gohelper.setActive(iter_17_1.reddot, var_17_2 and not var_17_1)
	end
end

function var_0_0._allFinished(arg_18_0)
	if not arg_18_0._moList then
		return false
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._moList) do
		if not InvestigateOpinionModel.instance:allOpinionLinked(iter_18_1.id) then
			return false
		end
	end

	return true
end

function var_0_0._checkFinish(arg_19_0)
	arg_19_0._isAllFinished = arg_19_0:_allFinished()

	gohelper.setActive(arg_19_0._gofullimg, arg_19_0._isAllFinished)
	gohelper.setActive(arg_19_0._goUnFinishedBg, not arg_19_0._isAllFinished)
end

function var_0_0.onSelect(arg_20_0, arg_20_1)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
