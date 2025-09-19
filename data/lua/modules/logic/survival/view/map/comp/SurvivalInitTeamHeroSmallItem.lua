module("modules.logic.survival.view.map.comp.SurvivalInitTeamHeroSmallItem", package.seeall)

local var_0_0 = class("SurvivalInitTeamHeroSmallItem", LuaCompBase)
local var_0_1 = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goHeroRoot = gohelper.findChild(arg_1_1, "#go_HaveHero")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_1, "#go_Empty")
	arg_1_0._goEmpty2 = gohelper.findChild(arg_1_1, "#go_Empty2")
	arg_1_0._goEmptyAdd = gohelper.findChild(arg_1_1, "#go_Empty/image_Add")
	arg_1_0._goLock = gohelper.findChild(arg_1_1, "#go_Locked")
	arg_1_0._goAssit = gohelper.findChild(arg_1_0._goHeroRoot, "assit")

	local var_1_0 = gohelper.findChild(arg_1_0._goHeroRoot, "hero")

	arg_1_0._imagerare = gohelper.findChildImage(var_1_0, "role/rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(var_1_0, "role/heroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(var_1_0, "role/career")
	arg_1_0._txtlv = gohelper.findChildText(var_1_0, "role/Lv")
	arg_1_0._goexskill = gohelper.findChild(var_1_0, "role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(var_1_0, "role/#go_exskill/#image_exskill")
	arg_1_0._goRankBg = gohelper.findChild(var_1_0, "role/Rank")
	arg_1_0._goranks = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		arg_1_0._goranks[iter_1_0] = gohelper.findChildImage(var_1_0, "role/Rank/rank" .. iter_1_0)
	end

	arg_1_0._clickThis = gohelper.getClick(arg_1_0.go)

	gohelper.setActive(arg_1_0._goLock, false)

	arg_1_0._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._goHeroRoot, SurvivalHeroHealthPart)
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

function var_0_0.getHeroMo(arg_6_0)
	return arg_6_0._heroMO
end

function var_0_0.setNoShowAdd(arg_7_0)
	arg_7_0._noShowAdd = true
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._heroMO = arg_8_1

	local var_8_0 = arg_8_0._heroMO ~= nil

	gohelper.setActive(arg_8_0._goEmpty, not var_8_0)
	gohelper.setActive(arg_8_0._goEmptyAdd, not var_8_0 and not arg_8_0._noShowAdd)
	gohelper.setActive(arg_8_0._goEmpty2, not var_8_0 and arg_8_0._noShowAdd and not arg_8_0._isLock)
	gohelper.setActive(arg_8_0._goHeroRoot, var_8_0)

	if var_8_0 then
		arg_8_0:updateBaseInfo(arg_8_1)
		arg_8_0._healthPart:setHeroId(arg_8_1.heroId)
	end
end

function var_0_0.setTrialValue(arg_9_0, arg_9_1)
	arg_9_0._isTrial = arg_9_1

	gohelper.setActive(arg_9_0._goAssit, arg_9_1)
end

function var_0_0.setIsLock(arg_10_0, arg_10_1)
	arg_10_0._isLock = arg_10_1

	if arg_10_1 then
		gohelper.setActive(arg_10_0._goLock, true)
		gohelper.setActive(arg_10_0._goHeroRoot, false)
		gohelper.setActive(arg_10_0._goEmpty, false)
	end
end

function var_0_0.showSelectEffect(arg_11_0)
	return
end

function var_0_0._onClickThis(arg_12_0)
	if SurvivalShelterModel.instance:getWeekInfo().inSurvival and not arg_12_0._isLock then
		if arg_12_0._heroMO then
			local var_12_0 = {}
			local var_12_1 = SurvivalMapModel.instance:getSceneMo().teamInfo

			for iter_12_0, iter_12_1 in ipairs(var_12_1.heros) do
				local var_12_2 = var_12_1:getHeroMo(iter_12_1)

				table.insert(var_12_0, var_12_2)
			end

			CharacterController.instance:openCharacterView(arg_12_0._heroMO, var_12_0)
		end

		return
	end

	if arg_12_0._isTrial or arg_12_0._isLock then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	SurvivalMapModel.instance:getInitGroup().curClickHeroIndex = arg_12_0._index

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)
	SurvivalMapModel.instance:getInitGroup():initHeroList()
	ViewMgr.instance:openView(ViewName.SurvivalInitHeroSelectView)
end

function var_0_0.updateBaseInfo(arg_13_0, arg_13_1)
	local var_13_0 = SkinConfig.instance:getSkinCo(arg_13_1.skin)
	local var_13_1 = arg_13_1.config

	arg_13_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(var_13_0.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_13_0._imagecareer, "lssx_" .. var_13_1.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_13_0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[var_13_1.rare]))

	local var_13_2, var_13_3, var_13_4 = SurvivalBalanceHelper.getHeroBalanceInfo(arg_13_1.heroId, arg_13_1)
	local var_13_5 = arg_13_1.rank
	local var_13_6 = var_13_3 and var_13_3 - 1 or var_13_5 - 1
	local var_13_7 = false

	for iter_13_0 = 1, 3 do
		local var_13_8 = iter_13_0 == var_13_6

		gohelper.setActive(arg_13_0._goranks[iter_13_0], var_13_8)

		var_13_7 = var_13_7 or var_13_8

		if var_13_8 and var_13_3 and var_13_5 < var_13_3 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_13_0._goranks[iter_13_0], SurvivalBalanceHelper.BalanceIconColor)
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_13_0._goranks[iter_13_0], "#F6F3EC")
		end
	end

	gohelper.setActive(arg_13_0._goRankBg, var_13_7)

	local var_13_9 = ""
	local var_13_10 = arg_13_1.level

	if var_13_2 and var_13_10 < var_13_2 then
		var_13_10 = var_13_2
		var_13_9 = "<color=" .. SurvivalBalanceHelper.BalanceColor .. ">"
	end

	arg_13_0._txtlv.text = var_13_9 .. "LV." .. tostring(HeroConfig.instance:getShowLevel(var_13_10))

	if arg_13_1.exSkillLevel <= 0 then
		gohelper.setActive(arg_13_0._goexskill, false)

		return
	end

	gohelper.setActive(arg_13_0._goexskill, true)

	arg_13_0._imageexskill.fillAmount = var_0_1[arg_13_1.exSkillLevel] or 1
end

function var_0_0.onDestroy(arg_14_0)
	arg_14_0._teamView = nil
end

return var_0_0
