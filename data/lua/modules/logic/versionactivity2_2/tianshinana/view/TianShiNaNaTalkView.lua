module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaTalkView", package.seeall)

local var_0_0 = class("TianShiNaNaTalkView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._rootTrans = gohelper.findChild(arg_1_0.viewGO, "root").transform
	arg_1_0._desc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Scroll View/Viewport/Content/txt_talk")
	arg_1_0._headIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Head/#simage_Head")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._onClickNext, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._steps = arg_4_0.viewParam
	arg_4_0._stepIndex = 0

	arg_4_0:_nextStep()
end

function var_0_0._onClickNext(arg_5_0)
	local var_5_0 = #arg_5_0._charArr

	if var_5_0 > 5 and arg_5_0._curShowCount < 5 then
		return
	end

	if var_5_0 == arg_5_0._curShowCount then
		arg_5_0:_nextStep()
	else
		arg_5_0._curShowCount = var_5_0 - 1

		arg_5_0:_showNextChar()
		TaskDispatcher.cancelTask(arg_5_0._showNextChar, arg_5_0)
	end
end

function var_0_0._nextStep(arg_6_0)
	arg_6_0._stepIndex = arg_6_0._stepIndex + 1

	local var_6_0 = arg_6_0._steps[arg_6_0._stepIndex]

	if not var_6_0 then
		arg_6_0:closeThis()

		return
	end

	local var_6_1 = TianShiNaNaEntityMgr.instance:getEntity(var_6_0.interactId)

	if not var_6_1 then
		logError("对话" .. var_6_0.id .. "找不到元件" .. var_6_0.interactId)
		arg_6_0:closeThis()

		return
	end

	local var_6_2 = var_6_1:getWorldPos()
	local var_6_3 = CameraMgr.instance:getUICamera()
	local var_6_4 = CameraMgr.instance:getMainCamera()
	local var_6_5 = recthelper.worldPosToAnchorPos(var_6_2, arg_6_0.viewGO.transform, var_6_3, var_6_4)

	recthelper.setAnchor(arg_6_0._rootTrans, var_6_5.x, var_6_5.y + 180)

	arg_6_0._curShowCount = 0
	arg_6_0._charArr = GameUtil.getUCharArrWithoutRichTxt(var_6_0.content)

	if not string.nilorempty(var_6_0.icon) then
		arg_6_0._curHeadIcon = var_6_0.icon
	end

	if arg_6_0._curHeadIcon then
		arg_6_0._headIcon:LoadImage(ResUrl.getHeadIconSmall(arg_6_0._curHeadIcon))
	end

	if #arg_6_0._charArr <= 1 then
		arg_6_0._desc.text = ""

		recthelper.setHeight(arg_6_0._rootTrans, 111)

		return
	end

	TaskDispatcher.runRepeat(arg_6_0._showNextChar, arg_6_0, 0.05, #arg_6_0._charArr - 1)
	arg_6_0:_showNextChar()
end

function var_0_0._showNextChar(arg_7_0)
	arg_7_0._curShowCount = arg_7_0._curShowCount + 1
	arg_7_0._desc.text = table.concat(arg_7_0._charArr, "", 1, arg_7_0._curShowCount)

	local var_7_0 = arg_7_0._desc.preferredHeight

	recthelper.setHeight(arg_7_0._rootTrans, math.max(111, var_7_0 + 40))
end

function var_0_0.onClose(arg_8_0)
	arg_8_0._headIcon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_8_0._showNextChar, arg_8_0)
end

return var_0_0
