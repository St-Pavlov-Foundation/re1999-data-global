module("modules.logic.survival.view.map.comp.SurvivalInitNPCSmallItem", package.seeall)

local var_0_0 = class("SurvivalInitNPCSmallItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goHaveNpc = gohelper.findChild(arg_1_1, "#go_HaveHero")
	arg_1_0._goLock = gohelper.findChild(arg_1_1, "#go_Locked")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_1, "#go_Empty")
	arg_1_0._goEmpty2 = gohelper.findChild(arg_1_1, "#go_Empty2")
	arg_1_0._goEmptyAdd = gohelper.findChild(arg_1_1, "#go_Empty/image_Add")
	arg_1_0._clickThis = gohelper.getClick(arg_1_1)
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0._goHaveNpc, "#txt_PartnerName")
	arg_1_0._imagechess = gohelper.findChildSingleImage(arg_1_0._goHaveNpc, "#image_Chess")
end

function var_0_0.setIndex(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1
end

function var_0_0.setParentView(arg_3_0, arg_3_1)
	arg_3_0._teamView = arg_3_1
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0._clickThis:AddClickListener(arg_4_0._onClickThis, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0._clickThis:RemoveClickListener()
end

function var_0_0.getNpcMo(arg_6_0)
	return arg_6_0._npcMo
end

function var_0_0.setNoShowAdd(arg_7_0)
	arg_7_0._noShowAdd = true
end

function var_0_0.setIsLock(arg_8_0, arg_8_1)
	arg_8_0._isLock = arg_8_1

	if arg_8_1 then
		gohelper.setActive(arg_8_0._goLock, true)
		gohelper.setActive(arg_8_0._goHaveNpc, false)
		gohelper.setActive(arg_8_0._goEmpty, false)
	end
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0.go, true)

	arg_9_0._npcMo = arg_9_1

	local var_9_0 = arg_9_0._npcMo ~= nil

	gohelper.setActive(arg_9_0._goEmpty, not var_9_0)
	gohelper.setActive(arg_9_0._goEmptyAdd, not var_9_0 and not arg_9_0._noShowAdd)
	gohelper.setActive(arg_9_0._goEmpty2, not var_9_0 and arg_9_0._noShowAdd and not arg_9_0._isLock)
	gohelper.setActive(arg_9_0._goHaveNpc, var_9_0)

	if var_9_0 then
		local var_9_1 = arg_9_1.co

		if not var_9_1 then
			return
		end

		arg_9_0._txtname.text = var_9_1.name

		SurvivalUnitIconHelper.instance:setNpcIcon(arg_9_0._imagechess, var_9_1.headIcon)
	end
end

function var_0_0.showSelectEffect(arg_10_0)
	return
end

function var_0_0._onClickThis(arg_11_0)
	if arg_11_0._isLock then
		return
	end

	if SurvivalShelterModel.instance:getWeekInfo().inSurvival then
		if arg_11_0._npcMo then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTeamNpc, arg_11_0._npcMo)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
	ViewMgr.instance:openView(ViewName.SurvivalNPCSelectView, arg_11_0._npcMo)
end

function var_0_0.hide(arg_12_0)
	gohelper.setActive(arg_12_0.go, false)
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._teamView = nil
end

return var_0_0
