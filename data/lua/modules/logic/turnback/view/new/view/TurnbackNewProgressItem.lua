module("modules.logic.turnback.view.new.view.TurnbackNewProgressItem", package.seeall)

local var_0_0 = class("TurnbackNewProgressItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	if arg_3_0.index == 1 or arg_3_0._isJump == true then
		arg_3_0._btnactivity:RemoveClickListener()
	end
end

function var_0_0.initItem(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1

	if arg_4_0.index == 1 then
		arg_4_0:initMainActivity()
	else
		arg_4_0:initNormalItem()
	end
end

function var_0_0.initMainActivity(arg_5_0)
	arg_5_0._btnactivity = gohelper.findChildButton(arg_5_0.go, "#btn_activity")

	arg_5_0._btnactivity:AddClickListener(arg_5_0._onClickMainActivity, arg_5_0)

	arg_5_0.txttitle = gohelper.findChildText(arg_5_0.go, "titlebg/#txt_title")
	arg_5_0.txttitle.text = TurnbackConfig.instance:getDropCoById(1).name
end

function var_0_0.initNormalItem(arg_6_0)
	arg_6_0.goprogress = gohelper.findChild(arg_6_0.go, "progress")
	arg_6_0.gounfinish = gohelper.findChild(arg_6_0.go, "progress/unfinish")
	arg_6_0.txtunfinish = gohelper.findChildText(arg_6_0.go, "progress/unfinish/#txt_progress")
	arg_6_0.imgunfinish = gohelper.findChildImage(arg_6_0.go, "progress/unfinish/bg/fill")
	arg_6_0.gofinished = gohelper.findChild(arg_6_0.go, "progress/finished")
	arg_6_0.simagepic = gohelper.findChildSingleImage(arg_6_0.go, "#simage_pic")
	arg_6_0._btnactivity = gohelper.findChildButton(arg_6_0.go, "#btn_activity")
	arg_6_0._gojumpicon = gohelper.findChild(arg_6_0.go, "icon")
end

function var_0_0._onClickMainActivity(arg_7_0)
	local var_7_0 = ActivityEnum.VersionActivityIdList[#ActivityEnum.VersionActivityIdList]
	local var_7_1 = ActivityHelper.getActivityVersion(var_7_0)

	_G[string.format("VersionActivity%sEnterController", var_7_1)]:openVersionActivityEnterView()
end

function var_0_0.refreshItem(arg_8_0, arg_8_1)
	arg_8_0.mo = arg_8_1
	arg_8_0.config = arg_8_0.mo.co
	arg_8_0._isJump = false

	local var_8_0 = not string.nilorempty(arg_8_0.config.jumpId)

	arg_8_0.simagepic:LoadImage(ResUrl.getTurnbackIcon("new/progress/" .. arg_8_0.config.picPath))

	arg_8_0.txttitle = gohelper.findChildText(arg_8_0.go, "titlebg/#txt_title")
	arg_8_0.txttitle.text = arg_8_0.config.name

	gohelper.setActive(arg_8_0._btnactivity.gameObject, var_8_0)
	gohelper.setActive(arg_8_0._gojumpicon, arg_8_0.config.type == TurnbackEnum.DropType.Jump)
	gohelper.setActive(arg_8_0.goprogress, arg_8_0.config.type == TurnbackEnum.DropType.Progress)

	if var_8_0 then
		arg_8_0._btnactivity:AddClickListener(arg_8_0._btnclickOnClick, arg_8_0)

		arg_8_0._isJump = true
	end

	if arg_8_0.config.type == TurnbackEnum.DropType.Progress then
		local var_8_1 = arg_8_0.mo and arg_8_0.mo.progress and arg_8_0.mo.progress < 1

		gohelper.setActive(arg_8_0.gounfinish, var_8_1)
		gohelper.setActive(arg_8_0.gofinished, not var_8_1)

		if var_8_1 then
			local var_8_2 = math.floor(arg_8_0.mo.progress * 100) / 100

			arg_8_0.txtunfinish.text = var_8_2 * 100 .. "%"
			arg_8_0.imgunfinish.fillAmount = arg_8_0.mo.progress
		end
	end
end

function var_0_0.refreshItemBySelf(arg_9_0)
	if arg_9_0.index > 1 then
		local var_9_0 = TurnbackModel.instance:getDropInfoByType(arg_9_0.config.id)

		if var_9_0 then
			arg_9_0:refreshItem(var_9_0)
		end
	end
end

function var_0_0._btnclickOnClick(arg_10_0)
	TurnbackRpc.instance:sendFinishReadTaskRequest(TurnbackEnum.ReadTaskId)
	StatController.instance:track(StatEnum.EventName.ReflowActivityJump, {
		[StatEnum.EventProperties.TurnbackJumpName] = arg_10_0.config.name,
		[StatEnum.EventProperties.TurnbackJumpId] = tostring(arg_10_0.config.id)
	})
	GameFacade.jump(arg_10_0.config.jumpId)
end

function var_0_0.onDestroy(arg_11_0)
	return
end

return var_0_0
