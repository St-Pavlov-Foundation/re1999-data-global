module("modules.logic.survival.view.map.comp.SurvivalMapSelectItem", package.seeall)

local var_0_0 = class("SurvivalMapSelectItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._callback = arg_1_1.callback
	arg_1_0._callobj = arg_1_1.callobj
	arg_1_0._index = arg_1_1.index
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._anim = gohelper.findChildAnim(arg_2_1, "")
	arg_2_0._golocked = gohelper.findChild(arg_2_1, "locked")
	arg_2_0._txtnamelock = gohelper.findChildTextMesh(arg_2_1, "locked/namebg/txt_map")
	arg_2_0._txtnameenlock = gohelper.findChildTextMesh(arg_2_1, "locked/namebg/txt_map/en")
	arg_2_0._gounlock = gohelper.findChild(arg_2_1, "unlock")
	arg_2_0._txtnameunlock = gohelper.findChildTextMesh(arg_2_1, "unlock/namebg/txt_map")
	arg_2_0._txtnameenunlock = gohelper.findChildTextMesh(arg_2_1, "unlock/namebg/txt_map/en")
	arg_2_0._goselect = gohelper.findChild(arg_2_1, "unlock/#go_select")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_1, "#btn_click")

	arg_2_0:_refreshView()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._onClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
end

function var_0_0._refreshView(arg_5_0)
	local var_5_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_5_0 then
		return
	end

	local var_5_1 = lua_survival_copy.configDict[arg_5_0._index]

	if not var_5_1 then
		return
	end

	arg_5_0._isLock = not var_5_0.copyIds[arg_5_0._index]

	if arg_5_0._isLock then
		local var_5_2 = var_5_0:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Base)

		arg_5_0._needLv = (var_5_2 and var_5_2.level or 0) + arg_5_0._index - #var_5_0.copyIds
	end

	gohelper.setActive(arg_5_0._golocked, arg_5_0._isLock)
	gohelper.setActive(arg_5_0._gounlock, not arg_5_0._isLock)

	arg_5_0._txtnamelock.text = GameUtil.setFirstStrSize(var_5_1.name, 56)
	arg_5_0._txtnameunlock.text = GameUtil.setFirstStrSize(var_5_1.name, 56)
	arg_5_0._txtnameenlock.text = var_5_1.enName
	arg_5_0._txtnameenunlock.text = var_5_1.enName
end

function var_0_0.playUnlockAnim(arg_6_0)
	gohelper.setActive(arg_6_0._golocked, true)
	gohelper.setActive(arg_6_0._gounlock, true)
	arg_6_0._anim:Play("unlock", 0, 0)
end

function var_0_0._onClick(arg_7_0)
	if arg_7_0._isLock then
		GameFacade.showToast(ToastEnum.SurvivalMapLock, arg_7_0._needLv)

		return
	end

	arg_7_0._callback(arg_7_0._callobj, arg_7_0._index)
end

function var_0_0.setIsSelect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goselect, arg_8_1)
end

return var_0_0
