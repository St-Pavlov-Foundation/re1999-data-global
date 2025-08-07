module("modules.logic.sp01.assassinChase.view.AssassinChaseOptionItem", package.seeall)

local var_0_0 = class("AssassinChaseOptionItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "#image_Icon")
	arg_1_0._txtPath = gohelper.findChildText(arg_1_0.viewGO, "#txt_Path")
	arg_1_0._txtTargetDescr = gohelper.findChildText(arg_1_0.viewGO, "#txt_TargetDescr")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0._btnClick = gohelper.findChildButton(arg_1_0.viewGO, "")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	return
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnClick:AddClickListener(arg_3_0.onBtnClickOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnClick:RemoveClickListener()
end

function var_0_0.onBtnClickOnClick(arg_5_0)
	local var_5_0 = AssassinChaseModel.instance:getCurInfoMo()

	if var_5_0:isSelect() and var_5_0:canChangeDirection() == false then
		local var_5_1 = TimeUtil.timestampToString4(var_5_0.changeEndTime)

		GameFacade.showToast(ToastEnum.AssassinChaseChangeTimeEndTip, {
			var_5_1
		})

		return
	end

	logNormal("奥德赛 下半活动 点击追逐方向 方向:" .. tostring(arg_5_0._directionId))
	AssassinChaseModel.instance:setCurDirectionId(arg_5_0._directionId)
end

function var_0_0.setData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._actId = arg_6_1
	arg_6_0._directionId = arg_6_2

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:setSelect(nil)

	if arg_7_0._directionId == nil then
		logError("奥德赛 下半活动 追逐游戏活动 方向id为空")
		arg_7_0:clear()

		return
	end

	local var_7_0 = AssassinChaseConfig.instance:getDirectionConfig(arg_7_0._actId, arg_7_0._directionId)

	if var_7_0 == nil then
		logError("奥德赛 下半活动 追逐游戏活动 方向id不存在 id:" .. arg_7_0._directionId)
		arg_7_0:clear()

		return
	end

	arg_7_0._txtPath.text = var_7_0.name
	arg_7_0._txtTargetDescr.text = var_7_0.des

	if string.nilorempty(var_7_0.pic) then
		return
	end

	UISpriteSetMgr.instance:setSp01Act205Sprite(arg_7_0._imageIcon, var_7_0.pic)
end

function var_0_0.setActive(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0.viewGO, arg_8_1)
end

function var_0_0.clear(arg_9_0)
	arg_9_0._directionId = nil

	arg_9_0:setActive(false)
	arg_9_0:setSelect(nil)
end

function var_0_0.setSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goSelected, arg_10_0._directionId and arg_10_0._directionId == arg_10_1)
end

function var_0_0.onDestroy(arg_11_0)
	return
end

return var_0_0
