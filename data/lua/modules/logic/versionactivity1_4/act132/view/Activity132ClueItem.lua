module("modules.logic.versionactivity1_4.act132.view.Activity132ClueItem", package.seeall)

local var_0_0 = class("Activity132ClueItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.index = arg_1_2
	arg_1_0._viewGO = arg_1_1
	arg_1_0._goRoot = gohelper.findChild(arg_1_1, "root")
	arg_1_0._maskGO = gohelper.findChild(arg_1_0._goRoot, "mask")
	arg_1_0._mask = arg_1_0._maskGO:GetComponent(typeof(Coffee.UISoftMask.SoftMask))
	arg_1_0._txtNode = gohelper.findChildTextMesh(arg_1_0._goRoot, "#txt_note")
	arg_1_0._goReddot = gohelper.findChild(arg_1_0._goRoot, "#go_reddot")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0._goRoot, "btn_click")
	arg_1_0._rect = arg_1_1.transform
	arg_1_0._redDot = RedDotController.instance:addRedDot(arg_1_0._goReddot, 1081, nil, arg_1_0.refreshRed, arg_1_0)

	arg_1_0:addClickCb(arg_1_0._btnClick, arg_1_0.onClickBtn, arg_1_0)
	arg_1_0:addEventCb(Activity132Controller.instance, Activity132Event.OnContentUnlock, arg_1_0.onRefreshRed, arg_1_0)
end

function var_0_0.refreshRed(arg_2_0)
	if not arg_2_0.data then
		return
	end

	local var_2_0 = Activity132Model.instance:checkClueRed(arg_2_0.data.activityId, arg_2_0.data.clueId)

	arg_2_0._redDot.show = var_2_0

	arg_2_0._redDot:showRedDot(1)
end

function var_0_0.onClickBtn(arg_3_0)
	if not arg_3_0.data then
		return
	end

	Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem, arg_3_0.index)
end

function var_0_0.resetMask(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = 0

	gohelper.addChild(arg_4_0._goRoot, arg_4_0._maskGO)
	gohelper.setAsFirstSibling(arg_4_0._maskGO)
	recthelper.setAnchor(arg_4_0._maskGO.transform, var_4_0, var_4_1)
	transformhelper.setLocalScale(arg_4_0._maskGO.transform, 2, 2, 2)
end

function var_0_0.setData(arg_5_0, arg_5_1)
	arg_5_0.data = arg_5_1

	arg_5_0:resetMask()

	if not arg_5_1 then
		arg_5_0:setActive(false)

		return
	end

	arg_5_0:setActive(false)
	arg_5_0:setActive(true)

	arg_5_0._txtNode.text = arg_5_0.data:getName()

	local var_5_0, var_5_1 = arg_5_0.data:getPos()

	recthelper.setAnchor(arg_5_0._rect, var_5_0, var_5_1)

	arg_5_0.posX, arg_5_0.posY, arg_5_0.posZ = transformhelper.getPos(arg_5_0._rect)

	arg_5_0._redDot:refreshDot()

	if arg_5_0._fadeTweenId then
		ZProj.TweenHelper.KillById(arg_5_0._fadeTweenId)

		arg_5_0._fadeTweenId = nil
	end

	arg_5_0._fadeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.34, arg_5_0.fadeUpdateCallback, nil, arg_5_0)
end

function var_0_0.fadeUpdateCallback(arg_6_0, arg_6_1)
	arg_6_0._mask.alpha = arg_6_1
end

function var_0_0.onRefreshRed(arg_7_0)
	if not arg_7_0.data then
		return
	end

	arg_7_0._redDot:refreshDot()
end

function var_0_0.setActive(arg_8_0, arg_8_1)
	if arg_8_0.isVisible == arg_8_1 then
		return
	end

	arg_8_0.isVisible = arg_8_1

	gohelper.setActive(arg_8_0._maskGO, arg_8_1)
	gohelper.setActive(arg_8_0._viewGO, arg_8_1)
end

function var_0_0.setRootVisible(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goRoot, arg_9_1)
end

function var_0_0.destroy(arg_10_0)
	if arg_10_0._fadeTweenId then
		ZProj.TweenHelper.KillById(arg_10_0._fadeTweenId)

		arg_10_0._fadeTweenId = nil
	end

	gohelper.destroy(arg_10_0._viewGO)
	arg_10_0:__onDispose()
end

function var_0_0.getMask(arg_11_0)
	return arg_11_0._maskGO
end

function var_0_0.getPos(arg_12_0)
	return arg_12_0.posX, arg_12_0.posY, arg_12_0.posZ
end

function var_0_0.getRealPos(arg_13_0)
	return transformhelper.getPos(arg_13_0._rect)
end

return var_0_0
