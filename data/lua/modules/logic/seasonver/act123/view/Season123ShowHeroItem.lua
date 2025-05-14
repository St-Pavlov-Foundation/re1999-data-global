module("modules.logic.seasonver.act123.view.Season123ShowHeroItem", package.seeall)

local var_0_0 = class("Season123ShowHeroItem", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()
end

function var_0_0.dispose(arg_2_0)
	arg_2_0:removeEvents()
	arg_2_0:__onDispose()
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.viewGO = gohelper.findChild(arg_3_1, "root")

	arg_3_0:initComponent()
end

var_0_0.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}
var_0_0.MaxRare = 5

function var_0_0.initComponent(arg_4_0)
	arg_4_0._goadd = gohelper.findChild(arg_4_0.viewGO, "#go_add")
	arg_4_0._gohero = gohelper.findChild(arg_4_0.viewGO, "#go_hero")
	arg_4_0._goempty = gohelper.findChild(arg_4_0.viewGO, "#go_empty")
	arg_4_0._goassist = gohelper.findChild(arg_4_0.viewGO, "#go_assit")
	arg_4_0._godead = gohelper.findChild(arg_4_0.viewGO, "#go_roledead")
	arg_4_0._simageicon = gohelper.findChildSingleImage(arg_4_0._gohero, "#simage_rolehead")
	arg_4_0._txtlevel = gohelper.findChildText(arg_4_0._gohero, "#txt_roleLv1")
	arg_4_0._txttalentevel2 = gohelper.findChildText(arg_4_0._gohero, "#txt_roleLv2")
	arg_4_0._goexskill = gohelper.findChild(arg_4_0._gohero, "#go_exskill")
	arg_4_0._imageexskill = gohelper.findChildImage(arg_4_0._gohero, "#go_exskill/#image_exskill")
	arg_4_0._imagecareer = gohelper.findChildImage(arg_4_0._gohero, "career")
	arg_4_0._goselfsupport = gohelper.findChild(arg_4_0.viewGO, "#btn_selfassit")
	arg_4_0._goothersupport = gohelper.findChild(arg_4_0.viewGO, "#btn_otherassit")
	arg_4_0._sliderhp = gohelper.findChildSlider(arg_4_0.viewGO, "#slider_hp")
	arg_4_0._imagehp = gohelper.findChildImage(arg_4_0.viewGO, "#slider_hp/Fill Area/Fill")
	arg_4_0._txtrolename = gohelper.findChildText(arg_4_0._gohero, "#txt_rolename")
	arg_4_0._gotalentline = gohelper.findChild(arg_4_0._gohero, "line")
	arg_4_0._rectheadicon = arg_4_0._simageicon.transform
	arg_4_0._gorank = gohelper.findChild(arg_4_0._gohero, "rank")
	arg_4_0._rankList = arg_4_0:getUserDataTb_()

	local var_4_0 = HeroConfig.instance:getMaxRank(var_0_0.MaxRare)

	for iter_4_0 = 1, var_4_0 do
		arg_4_0._rankList[iter_4_0] = gohelper.findChild(arg_4_0._gorank, "rank" .. tostring(iter_4_0))
	end

	arg_4_0._gorare = gohelper.findChild(arg_4_0._gohero, "rare")
	arg_4_0._rareList = arg_4_0:getUserDataTb_()

	for iter_4_1 = 1, CharacterEnum.MaxRare + 1 do
		arg_4_0._rareList[iter_4_1] = gohelper.findChild(arg_4_0._gorare, "go_rare" .. tostring(iter_4_1))
	end

	gohelper.setActive(arg_4_0._goselfsupport, false)
	gohelper.setActive(arg_4_0._goothersuppor, false)

	arg_4_0._heroAnim = arg_4_0._gohero:GetComponent(gohelper.Type_Animator)
end

function var_0_0.initData(arg_5_0, arg_5_1)
	arg_5_0._index = arg_5_1

	arg_5_0:refreshUI()
	arg_5_0:OpenAnim()
end

function var_0_0.removeEvents(arg_6_0)
	arg_6_0._btnclick:RemoveClickListener()
end

function var_0_0.onClose(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.playOpenAnim, arg_7_0)

	if arg_7_0._mo and arg_7_0._mo.hpRate <= 0 then
		Season123ShowHeroModel.instance:setPlayedHeroDieAnim(arg_7_0._mo.uid)
	end
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = Season123ShowHeroModel.instance:getByIndex(arg_8_0._index)

	arg_8_0._mo = var_8_0

	if var_8_0 then
		local var_8_1 = false

		gohelper.setActive(arg_8_0._goadd, false)
		gohelper.setActive(arg_8_0._goempty, false)
		gohelper.setActive(arg_8_0._gohero, true)

		local var_8_2 = SkinConfig.instance:getSkinCo(var_8_0.skin)

		if not var_8_2 then
			logError("Season123ShowHeroItem.refreshUI error, skinCfg is nil, id:" .. tostring(var_8_0.skin))

			return
		end

		arg_8_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(var_8_2.headIcon))

		if var_8_0.heroMO.config then
			arg_8_0._txtrolename.text = var_8_0.heroMO.config.name

			UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagecareer, "lssx_" .. tostring(var_8_0.heroMO.config.career))
		else
			arg_8_0._txtrolename.text = ""

			gohelper.setActive(arg_8_0._imagecareer, false)
		end

		arg_8_0:refreshRare(var_8_0.heroMO)
		arg_8_0:refreshRank(var_8_0.heroMO)
		arg_8_0:refreshExSkill(var_8_0.heroMO)
		arg_8_0:refreshHp(var_8_0)

		if var_8_0.heroMO then
			arg_8_0._txtlevel.text = "Lv." .. tostring(HeroConfig.instance:getShowLevel(var_8_0.heroMO.level))

			local var_8_3 = false

			if var_8_0.heroMO:isOtherPlayerHero() then
				var_8_3 = var_8_0.heroMO:getOtherPlayerIsOpenTalent()
			else
				local var_8_4 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent)
				local var_8_5 = var_8_0.heroMO.rank >= CharacterEnum.TalentRank

				var_8_3 = var_8_4 and var_8_5
			end

			if var_8_3 then
				gohelper.setActive(arg_8_0._gotalentline, true)
				gohelper.setActive(arg_8_0._txttalentevel2, true)

				arg_8_0._txttalentevel2.text = "Lv." .. tostring(var_8_0.heroMO.talent)
			else
				gohelper.setActive(arg_8_0._gotalentline, false)
				gohelper.setActive(arg_8_0._txttalentevel2, false)
			end
		else
			arg_8_0._txtlevel.text = ""

			gohelper.setActive(arg_8_0._gotalentline, false)
			gohelper.setActive(arg_8_0._txttalentevel2, false)
		end

		gohelper.setActive(arg_8_0._goassist, var_8_0.isAssist)
	else
		gohelper.setActive(arg_8_0._gohero, false)
		gohelper.setActive(arg_8_0._goempty, true)
	end
end

function var_0_0.refreshRare(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_0._rareList do
		gohelper.setActive(arg_9_0._rareList[iter_9_0], iter_9_0 <= arg_9_1.config.rare + 1)
	end
end

function var_0_0.refreshRank(arg_10_0, arg_10_1)
	if arg_10_1 and arg_10_1.rank and arg_10_1.rank > 1 then
		gohelper.setActive(arg_10_0._gorank, true)

		local var_10_0 = 5

		for iter_10_0 = 1, var_10_0 do
			gohelper.setActive(arg_10_0._rankList[iter_10_0], arg_10_1.rank - 1 == iter_10_0)
		end
	else
		gohelper.setActive(arg_10_0._gorank, false)
	end
end

function var_0_0.refreshExSkill(arg_11_0, arg_11_1)
	if arg_11_1.exSkillLevel <= 0 then
		arg_11_0._imageexskill.fillAmount = 0

		return
	end

	gohelper.setActive(arg_11_0._goexskill, true)

	arg_11_0._imageexskill.fillAmount = SummonCustomPickChoiceItem.exSkillFillAmount[arg_11_1.exSkillLevel] or 1
end

function var_0_0.refreshHp(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._sliderhp, true)

	local var_12_0 = math.floor(arg_12_1.hpRate / 10)
	local var_12_1 = Mathf.Clamp(var_12_0 / 100, 0, 1)

	arg_12_0._sliderhp:SetValue(var_12_1)

	if arg_12_1.hpRate <= 0 then
		gohelper.setActive(arg_12_0._godead, true)
	else
		gohelper.setActive(arg_12_0._godead, false)
	end

	Season123HeroGroupUtils.setHpBar(arg_12_0._imagehp, var_12_1)
end

function var_0_0.OpenAnim(arg_13_0)
	gohelper.setActive(arg_13_0.viewGO, false)

	local var_13_0 = (arg_13_0._index - 1) % 4 * 0.03

	TaskDispatcher.runDelay(arg_13_0.playOpenAnim, arg_13_0, var_13_0)
end

function var_0_0.playOpenAnim(arg_14_0)
	gohelper.setActive(arg_14_0.viewGO, true)

	local var_14_0 = "idle"

	if arg_14_0._mo and arg_14_0._mo.hpRate <= 0 then
		var_14_0 = Season123ShowHeroModel.instance:isFirstPlayHeroDieAnim(arg_14_0._mo.uid) and "todie" or "die"
	end

	arg_14_0._heroAnim:Play(var_14_0, 0, 0)
end

return var_0_0
