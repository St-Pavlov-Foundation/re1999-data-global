module("modules.logic.versionactivity2_5.act186.view.Activity186StageItem", package.seeall)

local var_0_0 = class("Activity186StageItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "goSelect")
	arg_1_0.goLock = gohelper.findChild(arg_1_0.viewGO, "goLock")
	arg_1_0.goTimeBg = gohelper.findChild(arg_1_0.viewGO, "goLock/timeBg")
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "goLock/timeBg/txt")
	arg_1_0.goEnd = gohelper.findChild(arg_1_0.viewGO, "goEnd")
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnClick:AddClickListener(arg_2_0.onClickBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtn(arg_5_0)
	if not arg_5_0._mo then
		return
	end

	local var_5_0 = arg_5_0._mo.actMo.currentStage
	local var_5_1

	var_5_1 = var_5_0 > arg_5_0._mo.id

	local var_5_2 = var_5_0 == arg_5_0._mo.id
	local var_5_3 = var_5_0 < arg_5_0._mo.id

	if var_5_2 then
		return
	end

	if var_5_3 then
		local var_5_4 = lua_actvity186_stage.configDict[arg_5_0._mo.actMo.id]
		local var_5_5 = var_5_4 and var_5_4[arg_5_0._mo.id]

		if var_5_5 then
			local var_5_6 = TimeUtil.stringToTimestamp(var_5_5.startTime) - ServerTime.now()
			local var_5_7 = math.ceil(var_5_6 / TimeUtil.OneDaySecond)
			local var_5_8 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), var_5_7)

			GameFacade.showToastString(var_5_8)
		end

		return
	end

	GameFacade.showToast(ToastEnum.Act186StageEnd)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshView()
end

function var_0_0.refreshView(arg_7_0)
	local var_7_0 = arg_7_0._mo.actMo.currentStage
	local var_7_1 = var_7_0 > arg_7_0._mo.id
	local var_7_2 = var_7_0 == arg_7_0._mo.id
	local var_7_3 = var_7_0 < arg_7_0._mo.id

	gohelper.setActive(arg_7_0.goSelect, var_7_2)
	gohelper.setActive(arg_7_0.goLock, var_7_3)
	gohelper.setActive(arg_7_0.goEnd, var_7_1)

	if var_7_0 + 1 == arg_7_0._mo.id then
		gohelper.setActive(arg_7_0.goTimeBg, true)
		arg_7_0:_showDeadline()
	else
		gohelper.setActive(arg_7_0.goTimeBg, false)
		TaskDispatcher.cancelTask(arg_7_0._onRefreshDeadline, arg_7_0)
	end
end

function var_0_0._showDeadline(arg_8_0)
	arg_8_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_8_0._onRefreshDeadline, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._onRefreshDeadline, arg_8_0, 1)
end

function var_0_0._onRefreshDeadline(arg_9_0)
	if not arg_9_0._mo then
		return
	end

	local var_9_0 = lua_actvity186_stage.configDict[arg_9_0._mo.actMo.id]
	local var_9_1 = var_9_0 and var_9_0[arg_9_0._mo.id]

	if not var_9_1 then
		return
	end

	local var_9_2 = TimeUtil.stringToTimestamp(var_9_1.startTime) - ServerTime.now()
	local var_9_3 = math.ceil(var_9_2 / TimeUtil.OneDaySecond)
	local var_9_4 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), var_9_3)

	arg_9_0.txtTime.text = var_9_4
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onRefreshDeadline, arg_10_0)
end

return var_0_0
