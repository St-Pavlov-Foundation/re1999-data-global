module("modules.logic.seasonver.act123.view2_0.Season123_2_0ShowHeroItem", package.seeall)

slot0 = class("Season123_2_0ShowHeroItem", UserDataDispose)

function slot0.ctor(slot0)
	slot0:__onInit()
end

function slot0.dispose(slot0)
	slot0:removeEvents()
	slot0:__onDispose()
end

function slot0.init(slot0, slot1)
	slot0.viewGO = gohelper.findChild(slot1, "root")

	slot0:initComponent()
end

slot0.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}
slot0.MaxRare = 5

function slot0.initComponent(slot0)
	slot0._goadd = gohelper.findChild(slot0.viewGO, "#go_add")
	slot0._gohero = gohelper.findChild(slot0.viewGO, "#go_hero")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._goassist = gohelper.findChild(slot0.viewGO, "#go_assit")
	slot0._godead = gohelper.findChild(slot0.viewGO, "#go_roledead")
	slot0._simageicon = gohelper.findChildSingleImage(slot0._gohero, "#simage_rolehead")
	slot0._txtlevel = gohelper.findChildText(slot0._gohero, "#txt_roleLv1")
	slot0._txttalentevel2 = gohelper.findChildText(slot0._gohero, "#txt_roleLv2")
	slot0._goexskill = gohelper.findChild(slot0._gohero, "#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot0._gohero, "#go_exskill/#image_exskill")
	slot0._imagecareer = gohelper.findChildImage(slot0._gohero, "career")
	slot0._goselfsupport = gohelper.findChild(slot0.viewGO, "#btn_selfassit")
	slot0._goothersupport = gohelper.findChild(slot0.viewGO, "#btn_otherassit")
	slot0._sliderhp = gohelper.findChildSlider(slot0.viewGO, "#slider_hp")
	slot0._imagehp = gohelper.findChildImage(slot0.viewGO, "#slider_hp/Fill Area/Fill")
	slot0._txtrolename = gohelper.findChildText(slot0._gohero, "#txt_rolename")
	slot0._gotalentline = gohelper.findChild(slot0._gohero, "line")
	slot0._rectheadicon = slot0._simageicon.transform
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_click")
	slot0._gorank = gohelper.findChild(slot0._gohero, "rank")
	slot0._rankList = slot0:getUserDataTb_()

	for slot5 = 1, HeroConfig.instance:getMaxRank(uv0.MaxRare) do
		slot0._rankList[slot5] = gohelper.findChild(slot0._gorank, "rank" .. tostring(slot5))
	end

	slot0._gorare = gohelper.findChild(slot0._gohero, "rare")
	slot0._rareList = slot0:getUserDataTb_()

	for slot5 = 1, CharacterEnum.MaxRare + 1 do
		slot0._rareList[slot5] = gohelper.findChild(slot0._gorare, "go_rare" .. tostring(slot5))
	end

	gohelper.setActive(slot0._goselfsupport, false)
	gohelper.setActive(slot0._goothersuppor, false)

	slot0._heroAnim = slot0._gohero:GetComponent(gohelper.Type_Animator)

	slot0._btnclick:AddClickListener(slot0.onClickSelf, slot0)
end

function slot0.initData(slot0, slot1)
	slot0._index = slot1

	slot0:refreshUI()
	slot0:OpenAnim()
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.playOpenAnim, slot0)

	if slot0._mo and slot0._mo.hpRate <= 0 then
		Season123ShowHeroModel.instance:setPlayedHeroDieAnim(slot0._mo.uid)
	end
end

function slot0.refreshUI(slot0)
	slot1 = Season123ShowHeroModel.instance:getByIndex(slot0._index)
	slot0._mo = slot1

	if slot1 then
		slot2 = false

		gohelper.setActive(slot0._goadd, false)
		gohelper.setActive(slot0._goempty, false)
		gohelper.setActive(slot0._gohero, true)

		if not SkinConfig.instance:getSkinCo(slot1.heroMO.skin) then
			logError("Season123_2_0ShowHeroItem.refreshUI error, skinCfg is nil, id:" .. tostring(slot1.heroMO.skin))

			return
		end

		slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot3.headIcon))

		if slot1.heroMO.config then
			slot0._txtrolename.text = slot1.heroMO.config.name

			UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot1.heroMO.config.career))
		else
			slot0._txtrolename.text = ""

			gohelper.setActive(slot0._imagecareer, false)
		end

		slot0:refreshRare(slot1.heroMO)
		slot0:refreshRank(slot1.heroMO)
		slot0:refreshExSkill(slot1.heroMO)
		slot0:refreshHp(slot1)

		if slot1.heroMO then
			slot0._txtlevel.text = "Lv." .. tostring(HeroConfig.instance:getShowLevel(slot1.heroMO.level))
			slot4 = false

			if (not slot1.heroMO:isOtherPlayerHero() or slot1.heroMO:getOtherPlayerIsOpenTalent()) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) and slot6 then
				gohelper.setActive(slot0._gotalentline, true)
				gohelper.setActive(slot0._txttalentevel2, true)

				slot0._txttalentevel2.text = "Lv." .. tostring(slot1.heroMO.talent)
			else
				gohelper.setActive(slot0._gotalentline, false)
				gohelper.setActive(slot0._txttalentevel2, false)
			end
		else
			slot0._txtlevel.text = ""

			gohelper.setActive(slot0._gotalentline, false)
			gohelper.setActive(slot0._txttalentevel2, false)
		end

		gohelper.setActive(slot0._goassist, slot1.isAssist)
	else
		gohelper.setActive(slot0._gohero, false)
		gohelper.setActive(slot0._goempty, true)
	end
end

function slot0.refreshRare(slot0, slot1)
	for slot5 = 1, #slot0._rareList do
		gohelper.setActive(slot0._rareList[slot5], slot5 <= slot1.config.rare + 1)
	end
end

function slot0.refreshRank(slot0, slot1)
	if slot1 and slot1.rank and slot1.rank > 1 then
		gohelper.setActive(slot0._gorank, true)

		for slot6 = 1, 5 do
			gohelper.setActive(slot0._rankList[slot6], slot1.rank - 1 == slot6)
		end
	else
		gohelper.setActive(slot0._gorank, false)
	end
end

function slot0.refreshExSkill(slot0, slot1)
	if slot1.exSkillLevel <= 0 then
		slot0._imageexskill.fillAmount = 0

		return
	end

	gohelper.setActive(slot0._goexskill, true)

	slot0._imageexskill.fillAmount = SummonCustomPickChoiceItem.exSkillFillAmount[slot1.exSkillLevel] or 1
end

function slot0.refreshHp(slot0, slot1)
	gohelper.setActive(slot0._sliderhp, true)
	slot0._sliderhp:SetValue(Mathf.Clamp(math.floor(slot1.hpRate / 10) / 100, 0, 1))

	if slot1.hpRate <= 0 then
		gohelper.setActive(slot0._godead, true)
	else
		gohelper.setActive(slot0._godead, false)
	end

	Season123HeroGroupUtils.setHpBar(slot0._imagehp, slot3)
end

function slot0.onClickSelf(slot0)
	logNormal("onClickSelf ： " .. tostring(slot0._index))

	if not Season123ShowHeroModel.instance:getByIndex(slot0._index) then
		return
	end

	if slot1.hpRate <= 0 then
		GameFacade.showToast(ToastEnum.Season123HeroDead)

		return
	end

	if slot0._index == Activity123Enum.SupportPosIndex and slot1.isSupport then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(Season123ShowHeroModel.instance:getList()) do
		if slot8.hpRate > 0 then
			table.insert(slot3, slot8.heroMO)
		end
	end

	CharacterController.instance:openCharacterView(slot1.heroMO, slot3)
end

function slot0.OpenAnim(slot0)
	gohelper.setActive(slot0.viewGO, false)
	TaskDispatcher.runDelay(slot0.playOpenAnim, slot0, (slot0._index - 1) % 4 * 0.03)
end

function slot0.playOpenAnim(slot0)
	gohelper.setActive(slot0.viewGO, true)

	slot1 = "idle"

	if slot0._mo and slot0._mo.hpRate <= 0 then
		slot1 = Season123ShowHeroModel.instance:isFirstPlayHeroDieAnim(slot0._mo.uid) and "todie" or "die"
	end

	slot0._heroAnim:Play(slot1, 0, 0)
end

return slot0
