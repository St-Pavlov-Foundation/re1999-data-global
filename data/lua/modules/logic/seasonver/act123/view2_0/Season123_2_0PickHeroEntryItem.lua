module("modules.logic.seasonver.act123.view2_0.Season123_2_0PickHeroEntryItem", package.seeall)

slot0 = class("Season123_2_0PickHeroEntryItem", UserDataDispose)

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
	slot0._goassist = gohelper.findChild(slot0.viewGO, "#go_assit")
	slot0._simageicon = gohelper.findChildSingleImage(slot0._gohero, "#simage_rolehead")
	slot0._txtlevel = gohelper.findChildText(slot0._gohero, "#txt_roleLv1")
	slot0._txttalentevel2 = gohelper.findChildText(slot0._gohero, "#txt_roleLv2")
	slot0._goexskill = gohelper.findChild(slot0._gohero, "#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot0._gohero, "#go_exskill/#image_exskill")
	slot0._imagecareer = gohelper.findChildImage(slot0._gohero, "career")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_click")
	slot0._btnselfsupport = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_selfassit")
	slot0._btnothersupport = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_otherassit")
	slot0._txtrolename = gohelper.findChildText(slot0._gohero, "#txt_rolename")
	slot0._gotalentline = gohelper.findChild(slot0._gohero, "line")
	slot0._gosliderhp = gohelper.findChild(slot0.viewGO, "#slider_hp")
	slot0._gorank = gohelper.findChild(slot0._gohero, "rank")
	slot0._gocuthero = gohelper.findChild(slot0.viewGO, "#click")
	slot0._animCuthero = gohelper.findChild(slot0._gocuthero, "ani"):GetComponent(typeof(UnityEngine.Animator))
	slot0._rankList = slot0:getUserDataTb_()

	for slot6 = 1, HeroConfig.instance:getMaxRank(uv0.MaxRare) do
		slot0._rankList[slot6] = gohelper.findChild(slot0._gorank, "rank" .. tostring(slot6))
	end

	slot0._gorare = gohelper.findChild(slot0._gohero, "rare")
	slot0._rareList = slot0:getUserDataTb_()

	for slot6 = 1, CharacterEnum.MaxRare + 1 do
		slot0._rareList[slot6] = gohelper.findChild(slot0._gorare, "go_rare" .. tostring(slot6))
	end

	slot0._btnclick:AddClickListener(slot0.onClickSelf, slot0)
	slot0._btnselfsupport:AddClickListener(slot0.onClickSupport, slot0)
	slot0._btnothersupport:AddClickListener(slot0.onClickSupport, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnselfsupport:RemoveClickListener()
	slot0._btnothersupport:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0.playOpenAnim, slot0)
end

function slot0.initData(slot0, slot1)
	slot0._index = slot1

	slot0:refreshUI()
	slot0:OpenAnim()
end

function slot0.refreshUI(slot0)
	if Season123PickHeroEntryModel.instance:getByIndex(slot0._index) then
		slot2 = slot1:getIsEmpty()

		gohelper.setActive(slot0._goadd, slot2)
		gohelper.setActive(slot0._gohero, not slot2)

		if not slot2 then
			if slot1.heroMO and slot1.heroMO.config then
				slot0._txtrolename.text = slot1.heroMO.config.name

				UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot1.heroMO.config.career))
			else
				slot0._txtrolename.text = ""

				gohelper.setActive(slot0._imagecareer, false)
			end

			slot0:refreshRare(slot1.heroMO)
			slot0:refreshRank(slot1.heroMO)
			slot0:refreshExSkill(slot1.heroMO)

			if slot1.heroMO then
				if not SkinConfig.instance:getSkinCo(slot1.heroMO.skin) then
					logError("Season123_2_0PickHeroEntryItem.refreshUI error, skinCfg is nil, id:" .. tostring(slot1.skinId))

					return
				end

				slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot3.headIcon))

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
		end
	end

	if slot0._index == Activity123Enum.SupportPosIndex then
		gohelper.setActive(slot0._goassist, slot2 and slot1 and slot1.isSupport)
		gohelper.setActive(slot0._btnselfsupport, slot1 and (not slot1.isSupport or slot1:getIsEmpty()))
		gohelper.setActive(slot0._btnothersupport, slot1 and slot1.isSupport)
	else
		gohelper.setActive(slot0._goassist, false)
		gohelper.setActive(slot0._btnselfsupport, false)
		gohelper.setActive(slot0._btnothersupport, false)
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

function slot0.onClickSelf(slot0)
	logNormal("onClickSelf ： " .. tostring(slot0._index))

	if slot0._index == Activity123Enum.SupportPosIndex and Season123PickHeroEntryModel.instance:getByIndex(slot0._index).isSupport then
		Season123PickHeroEntryController.instance:openPickSupportView()

		return
	end

	Season123PickHeroEntryController.instance:openPickHeroView(slot0._index)
end

function slot0.onClickSupport(slot0)
	if slot0._index == Activity123Enum.SupportPosIndex then
		if Season123PickHeroEntryModel.instance:getByIndex(slot0._index).isSupport then
			GameFacade.showMessageBox(MessageBoxIdDefine.Season123CancelAssist, MsgBoxEnum.BoxType.Yes_No, Season123PickHeroEntryController.instance.cancelSupport, nil, , Season123PickHeroEntryController.instance, nil)

			return
		end

		Season123PickHeroEntryController.instance:openPickSupportView(true)
	end
end

function slot0.OpenAnim(slot0)
	gohelper.setActive(slot0.viewGO, false)
	TaskDispatcher.runDelay(slot0.playOpenAnim, slot0, (slot0._index - 1) % 4 * 0.03)
end

function slot0.playOpenAnim(slot0)
	gohelper.setActive(slot0.viewGO, true)
end

function slot0.cutHeroAnim(slot0, slot1)
	gohelper.setActive(slot0._gocuthero, slot1)
	slot0._animCuthero:Play("pickheroentryview_click", 0, 0)
end

return slot0
