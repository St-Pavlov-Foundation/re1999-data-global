module("modules.logic.gm.view.GMGuideStatusView", package.seeall)

local var_0_0 = class("GMGuideStatusView", BaseView)
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btnClose")
	arg_1_0._btnShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btnShow")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btnHide")
	arg_1_0._rect = gohelper.findChild(arg_1_0.viewGO, "view").transform
	arg_1_0._btnOp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/title/btnOp")
	arg_1_0._btnScroll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/title/btnScroll")
	arg_1_0._btnDelete = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/title/btnDelete")
	arg_1_0._btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/title/btnFinish")
	arg_1_0._btnReverse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/title/btnReverse")
	arg_1_0._textBtnReverse = gohelper.findChildText(arg_1_0.viewGO, "view/title/btnReverse/Text")
	arg_1_0._inputSearch = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "view/title/btnOp/InputField")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnShow:AddClickListener(arg_2_0._onClickShow, arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._onClickHide, arg_2_0)
	arg_2_0._btnOp:AddClickListener(arg_2_0._onClickOp, arg_2_0)
	arg_2_0._btnScroll:AddClickListener(arg_2_0._onClickScroll, arg_2_0)
	arg_2_0._btnDelete:AddClickListener(arg_2_0._onClickDelete, arg_2_0)
	arg_2_0._btnFinish:AddClickListener(arg_2_0._onClickFinish, arg_2_0)
	arg_2_0._btnReverse:AddClickListener(arg_2_0._onClicReverse, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnShow:RemoveClickListener()
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0._btnOp:RemoveClickListener()
	arg_3_0._btnScroll:RemoveClickListener()
	arg_3_0._btnDelete:RemoveClickListener()
	arg_3_0._btnFinish:RemoveClickListener()
	arg_3_0._btnReverse:RemoveClickListener()

	if arg_3_0._inputSearch then
		arg_3_0._inputSearch:RemoveOnValueChanged()
		arg_3_0._inputSearch:RemoveOnEndEdit()
	end
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._state = var_0_1

	arg_4_0:_updateBtns()
	TaskDispatcher.runRepeat(arg_4_0._updateUI, arg_4_0, 0.5)
	arg_4_0:_updateBtnReverseText()
end

function var_0_0.onClose(arg_5_0)
	if arg_5_0._tweenId then
		ZProj.TweenHelper.KillById(arg_5_0._tweenId)

		arg_5_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_5_0._updateUI, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayCancelForbid, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._dealFinishSecond, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onFrameDeleteGuides, arg_5_0)
	UIBlockMgr.instance:endBlock("GMGuideStatusOneKeyFinish")
	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, arg_5_0._onStartGuide, arg_5_0)
	arg_5_0:_delayCancelForbid()
end

function var_0_0._updateUI(arg_6_0)
	GMGuideStatusModel.instance:updateModel()
end

function var_0_0._onClickShow(arg_7_0)
	if arg_7_0._state == var_0_2 then
		arg_7_0._state = var_0_3
		arg_7_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_7_0._rect, 0, 0.2, arg_7_0._onShow, arg_7_0)
	end
end

function var_0_0._onShow(arg_8_0)
	arg_8_0._tweenId = nil
	arg_8_0._state = var_0_1

	arg_8_0:_updateBtns()
end

function var_0_0._onClickHide(arg_9_0)
	if arg_9_0._state == var_0_1 then
		arg_9_0._state = var_0_3
		arg_9_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_9_0._rect, -800, 0.2, arg_9_0._onHide, arg_9_0)
	end
end

function var_0_0._onClickOp(arg_10_0)
	if arg_10_0._inputSearch then
		arg_10_0._inputSearch:SetText(GMGuideStatusModel.instance:getSearch())
		gohelper.setActive(arg_10_0._inputSearch.gameObject, true)
		arg_10_0._inputSearch:AddOnValueChanged(arg_10_0._onSearchValueChanged, arg_10_0)
		arg_10_0._inputSearch:AddOnEndEdit(arg_10_0._onSearchEndEdit, arg_10_0)
	end
end

function var_0_0._onSearchValueChanged(arg_11_0, arg_11_1)
	GMGuideStatusModel.instance:setSearch(arg_11_1)
end

function var_0_0._onSearchEndEdit(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._inputSearch.gameObject, false)
end

function var_0_0._onClickScroll(arg_13_0)
	local var_13_0 = gohelper.onceAddComponent(gohelper.findChild(arg_13_0.viewGO, "view/scroll"), typeof(UnityEngine.CanvasGroup))

	var_13_0.blocksRaycasts = not var_13_0.blocksRaycasts

	GMGuideStatusModel.instance:onClickShowOpBtn()

	gohelper.findChildText(arg_13_0._btnScroll.gameObject, "Text").text = var_13_0.blocksRaycasts and "点击穿透" or "允许操作"
end

function var_0_0._onClickDelete(arg_14_0)
	local var_14_0 = GuideModel.instance:getList()

	arg_14_0._toDeleteGuides = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		table.insert(arg_14_0._toDeleteGuides, iter_14_1.id)
	end

	TaskDispatcher.runRepeat(arg_14_0._onFrameDeleteGuides, arg_14_0, 0.033)
end

function var_0_0._onFrameDeleteGuides(arg_15_0)
	if arg_15_0._toDeleteGuides and #arg_15_0._toDeleteGuides > 0 then
		local var_15_0 = table.remove(arg_15_0._toDeleteGuides, 1)

		GMRpc.instance:sendGMRequest("delete guide " .. var_15_0)
		GuideStepController.instance:clearFlow(var_15_0)
		GuideModel.instance:remove(GuideModel.instance:getById(var_15_0))

		if #arg_15_0._toDeleteGuides % 30 == 0 and #arg_15_0._toDeleteGuides > 0 then
			GameFacade.showToast(ToastEnum.IconId, "left:" .. #arg_15_0._toDeleteGuides)
		end
	end

	if not arg_15_0._toDeleteGuides or #arg_15_0._toDeleteGuides == 0 then
		GameFacade.showToast(ToastEnum.IconId, "finish")

		arg_15_0._toDeleteGuides = nil

		TaskDispatcher.cancelTask(arg_15_0._onFrameDeleteGuides, arg_15_0)
	end
end

function var_0_0._onClickFinish(arg_16_0)
	arg_16_0._needFinishGuides = {}
	arg_16_0._needDelayFinishGuides = {}

	local var_16_0 = GuideConfig.instance:getGuideList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = iter_16_1.id
		local var_16_2 = GuideModel.instance:getById(var_16_1)

		if var_16_2 then
			if not var_16_2.isFinish then
				GuideStepController.instance:clearFlow(var_16_1)
				table.insert(arg_16_0._needFinishGuides, var_16_1)
			end
		else
			table.insert(arg_16_0._needDelayFinishGuides, var_16_1)
		end
	end

	if #arg_16_0._needDelayFinishGuides > 0 then
		arg_16_0._prevForbidStatus = GuideController.instance:isForbidGuides()

		if not arg_16_0._prevForbidStatus then
			GuideController.instance:tempForbidGuides(true)
		end

		GuideController.instance:registerCallback(GuideEvent.StartGuide, arg_16_0._onStartGuide, arg_16_0)
	end

	if #arg_16_0._needFinishGuides > 0 or #arg_16_0._needDelayFinishGuides > 0 then
		arg_16_0:_dealFinishSecond()
		TaskDispatcher.runRepeat(arg_16_0._dealFinishSecond, arg_16_0, 0.01)
	end
end

local var_0_4 = 60

function var_0_0._dealFinishSecond(arg_17_0)
	arg_17_0._hasSendGuideTimes = arg_17_0._hasSendGuideTimes or {}

	local var_17_0 = Time.realtimeSinceStartup
	local var_17_1 = #arg_17_0._hasSendGuideTimes

	for iter_17_0 = 1, var_17_1 do
		if var_17_0 - arg_17_0._hasSendGuideTimes[1] > 1 then
			table.remove(arg_17_0._hasSendGuideTimes, 1)
		end
	end

	if #arg_17_0._hasSendGuideTimes < var_0_4 then
		if #arg_17_0._needFinishGuides > 0 then
			local var_17_2 = table.remove(arg_17_0._needFinishGuides, 1)

			arg_17_0:_sendFinishGuide(var_17_2)
		elseif #arg_17_0._needDelayFinishGuides > 0 then
			local var_17_3 = table.remove(arg_17_0._needDelayFinishGuides, 1)

			GuideController.instance:startGudie(var_17_3)
			table.insert(arg_17_0._hasSendGuideTimes, var_17_0)
		end
	end

	local var_17_4 = (arg_17_0._needFinishGuides and #arg_17_0._needFinishGuides or 0) + (arg_17_0._needDelayFinishGuides and #arg_17_0._needDelayFinishGuides or 0)

	if var_17_4 > 0 then
		if var_17_4 % 20 == 0 then
			GameFacade.showToast(ToastEnum.IconId, "left: " .. var_17_4)
		end

		UIBlockMgr.instance:startBlock("GMGuideStatusOneKeyFinish")
	else
		UIBlockMgr.instance:endBlock("GMGuideStatusOneKeyFinish")
		GameFacade.showToast(ToastEnum.IconId, "finish")
		TaskDispatcher.runDelay(arg_17_0._delayCancelForbid, arg_17_0, 1)
		TaskDispatcher.cancelTask(arg_17_0._dealFinishSecond, arg_17_0)
	end
end

function var_0_0._onClicReverse(arg_18_0)
	GMGuideStatusModel.instance:onClickReverse()
	arg_18_0:_updateBtnReverseText()
end

function var_0_0._delayCancelForbid(arg_19_0)
	if not arg_19_0._prevForbidStatus then
		GuideController.instance:tempForbidGuides(false)
	end

	arg_19_0._prevForbidStatus = nil

	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, arg_19_0._onStartGuide, arg_19_0)
end

function var_0_0._onStartGuide(arg_20_0, arg_20_1)
	GuideStepController.instance:clearFlow(arg_20_1)
	arg_20_0:_sendFinishGuide(arg_20_1)
end

function var_0_0._sendFinishGuide(arg_21_0, arg_21_1)
	if not GuideModel.instance:getById(arg_21_1) then
		return
	end

	local var_21_0 = GuideConfig.instance:getStepList(arg_21_1)

	for iter_21_0 = #var_21_0, 1, -1 do
		local var_21_1 = var_21_0[iter_21_0]

		if var_21_1.keyStep == 1 then
			arg_21_0._hasSendGuideTimes = arg_21_0._hasSendGuideTimes or {}

			table.insert(arg_21_0._hasSendGuideTimes, Time.realtimeSinceStartup)
			GuideRpc.instance:sendFinishGuideRequest(arg_21_1, var_21_1.stepId)

			break
		end
	end
end

function var_0_0._updateBtnReverseText(arg_22_0)
	arg_22_0._textBtnReverse.text = GMGuideStatusModel.instance.idReverse and luaLang("p_roombuildingfilterview_raredown") or luaLang("p_roombuildingfilterview_rareup")
end

function var_0_0._onHide(arg_23_0)
	arg_23_0._tweenId = nil
	arg_23_0._state = var_0_2

	arg_23_0:_updateBtns()
end

function var_0_0._updateBtns(arg_24_0)
	gohelper.setActive(arg_24_0._btnShow.gameObject, arg_24_0._state == var_0_2)
	gohelper.setActive(arg_24_0._btnHide.gameObject, arg_24_0._state == var_0_1)
end

return var_0_0
