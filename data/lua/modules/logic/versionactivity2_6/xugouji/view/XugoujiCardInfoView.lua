module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardInfoView", package.seeall)

local var_0_0 = class("XugoujiCardInfoView", BaseView)
local var_0_1 = Vector2(-530, -60)
local var_0_2 = Vector2(530, -60)
local var_0_3 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goInfo = gohelper.findChild(arg_1_0.viewGO, "#go_Tips")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0._goInfo, "Scroll View/Viewport/#txt_Descr")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0._goInfo, "Info/#txt_ChessName")
	arg_1_0._cardIcon = gohelper.findChildImage(arg_1_0._goInfo, "Info/#image_Skill")
	arg_1_0._viewAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)

	arg_1_0:addEventCb(XugoujiController.instance, XugoujiEvent.ManualExitGame, arg_1_0.closeThis, arg_1_0)
	arg_1_0:addEventCb(XugoujiController.instance, XugoujiEvent.OnOpenGameResultView, arg_1_0.closeThis, arg_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._onCloseClick, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.GuideCloseCardInfoView, arg_2_0._closeByGuide, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.GuideCloseCardInfoView, arg_3_0._closeByGuide, arg_3_0)
end

function var_0_0.closeThis(arg_4_0)
	BaseView.closeThis(arg_4_0)
end

function var_0_0._onCloseClick(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onCloseClick, arg_5_0)
	gohelper.setActive(arg_5_0._btnClose.gameObject, false)
	arg_5_0._viewAnimator:Play(UIAnimationName.Close, arg_5_0.closeThis, arg_5_0)
end

function var_0_0._closeByGuide(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._onCloseClick, arg_6_0)
	gohelper.setActive(arg_6_0._btnClose.gameObject, false)
	arg_6_0._viewAnimator:Play(UIAnimationName.Close, arg_6_0.closeThis, arg_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.cardId
	local var_8_1 = Activity188Model.instance:isMyTurn()
	local var_8_2 = arg_8_0._goInfo.transform
	local var_8_3 = var_8_1 and var_0_1 or var_0_2
	local var_8_4 = Activity188Config.instance:getCardCfg(var_0_3, var_8_0)

	recthelper.setAnchor(var_8_2, var_8_3.x, var_8_3.y)

	arg_8_0._txtDesc.text = var_8_4.desc
	arg_8_0._txtName.text = var_8_4.name

	local var_8_5 = var_8_4.resource

	if var_8_5 and var_8_5 ~= "" then
		UISpriteSetMgr.instance:setXugoujiSprite(arg_8_0._cardIcon, var_8_5)
	end

	if not var_8_1 then
		TaskDispatcher.runDelay(arg_8_0._onCloseClick, arg_8_0, 2)
	end

	gohelper.setActive(arg_8_0._btnClose.gameObject, true)
end

function var_0_0.onClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onCloseClick, arg_9_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.CloseCardInfoView)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
