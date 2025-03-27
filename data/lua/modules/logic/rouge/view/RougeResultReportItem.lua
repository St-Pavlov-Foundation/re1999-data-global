module("modules.logic.rouge.view.RougeResultReportItem", package.seeall)

slot0 = class("RougeResultReportItem", ListScrollCellExtend)
slot0.DefaultTitleImageUrl = "singlebg_lang/txt_rouge/enter/rouge_enter_titlebg.png"

function slot0.onInitView(slot0)
	slot0._simageredbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_redbg")
	slot0._simagegreenbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_greenbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_time")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#go_time/#txt_time")
	slot0._godifficulty = gohelper.findChild(slot0.viewGO, "#go_difficulty")
	slot0._txtdifficulty = gohelper.findChildText(slot0.viewGO, "#go_difficulty/#txt_difficulty")
	slot0._gofaction = gohelper.findChild(slot0.viewGO, "#go_faction")
	slot0._imageTypeIcon = gohelper.findChildImage(slot0.viewGO, "#go_faction/#image_TypeIcon")
	slot0._txtTypeName = gohelper.findChildText(slot0.viewGO, "#go_faction/image_NameBG/#txt_TypeName")
	slot0._txtLv = gohelper.findChildText(slot0.viewGO, "#go_faction/#txt_Lv")
	slot0._imagePointIcon = gohelper.findChildImage(slot0.viewGO, "#go_faction/layout/#image_PointIcon")
	slot0._goherogroup = gohelper.findChild(slot0.viewGO, "#go_herogroup")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item1")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item2")
	slot0._goitem3 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item3")
	slot0._goitem4 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item4")
	slot0._goitem5 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item5")
	slot0._goitem6 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item6")
	slot0._goitem7 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item7")
	slot0._goitem8 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item8")
	slot0._godec = gohelper.findChild(slot0.viewGO, "#go_dec")
	slot0._godecred = gohelper.findChild(slot0.viewGO, "#go_dec/#go_dec_red")
	slot0._godecgreen = gohelper.findChild(slot0.viewGO, "#go_dec/#go_dec_green")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#go_dec/#txt_dec")
	slot0._btndetails = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_details")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetails:AddClickListener(slot0._btndetailsOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetails:RemoveClickListener()
end

function slot0._btndetailsOnClick(slot0)
	RougeController.instance:openRougeResultReView({
		showNavigate = true,
		reviewInfo = slot0._mo
	})
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshEnding(slot1)
	slot0:refreshStyleInfo(slot1)
	slot0:refreshPlayerInfo(slot1)
	slot0:refreshBaseInfo(slot1)
	slot0:refreshHeroGroup(slot1)
	slot0:refreshTitle(slot1)

	slot0._txtdec.text = RougeResultReView.refreshEndingDesc(slot1)
	slot2 = slot1:isSucceed()

	gohelper.setActive(slot0._godecgreen, slot2)
	gohelper.setActive(slot0._godecred, not slot2)
	gohelper.setActive(slot0._simagegreenbg, slot2)
	gohelper.setActive(slot0._simageredbg, not slot2)

	if UnityEngine.Time.frameCount - RougeResultReportListModel.instance.startFrameCount < 10 then
		slot0._aniamtor = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)

		slot0._aniamtor:Play("open")
	end
end

function slot0.refreshHeroGroup(slot0, slot1)
	if not slot0._heroItemList then
		slot0._heroItemList = slot0:getUserDataTb_()

		for slot5 = 1, 8 do
			slot8 = slot0._view:getResInst(slot0._view.viewContainer._viewSetting.otherRes[2], slot0["_goitem" .. slot5])
			slot0._heroItemList[slot5] = {
				simagerolehead = gohelper.findChildSingleImage(slot8, "#go_heroitem/#image_rolehead"),
				frame = gohelper.findChild(slot8, "#go_heroitem/frame"),
				empty = gohelper.findChild(slot8, "#go_heroitem/empty")
			}
		end
	end

	for slot5, slot6 in ipairs(slot0._heroItemList) do
		slot8 = slot0._mo.teamInfo.heroLifeList[slot5] ~= nil

		gohelper.setActive(slot6.simagerolehead, slot8)
		gohelper.setActive(slot6.frame, slot8)
		gohelper.setActive(slot6.empty, not slot8)

		if slot8 then
			slot9 = slot7 and slot7.heroId
			slot10 = nil
			slot10 = (not HeroModel.instance:getByHeroId(slot9) or HeroModel.instance:getCurrentSkinConfig(slot9)) and SkinConfig.instance:getSkinCo(HeroConfig.instance:getHeroCO(slot9) and slot12.skinId)

			slot6.simagerolehead:LoadImage(ResUrl.getHeadIconSmall(slot10 and slot10.headIcon))
		end
	end
end

function slot0.refreshEnding(slot0, slot1)
	slot3 = slot1.endId > 0

	gohelper.setActive(slot0._godecgreen, slot3)
	gohelper.setActive(slot0._godecred, not slot3)
	gohelper.setActive(slot0._simagegreenbg, slot3)
	gohelper.setActive(slot0._simageredbg, not slot3)
end

function slot0.refreshBaseInfo(slot0, slot1)
	slot2 = slot1.collectionNum
	slot3 = slot1.gainCoin
	slot0._txtdifficulty.text = lua_rouge_difficulty.configDict[slot1.season][slot1.difficulty] and slot6.title
	slot0._txtLv.text = string.format("Lv.%s", slot1.teamLevel)
end

function slot0.refreshPlayerInfo(slot0, slot1)
	slot2 = slot1.playerName
	slot3 = slot1.playerLevel
	slot0._txttime.text = TimeUtil.localTime2ServerTimeString(slot1.finishTime / 1000, "%Y.%m.%d %H:%M")
	slot5 = ItemConfig.instance:getItemIconById(slot1.portrait)
end

function slot0.refreshStyleInfo(slot0, slot1)
	slot0._txtTypeName.text = lua_rouge_style.configDict[slot1.season][slot1.style] and slot4.name

	if slot4 then
		UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageTypeIcon, string.format("%s_light", slot4 and slot4.icon))
		UISpriteSetMgr.instance:setRouge2Sprite(slot0._imagePointIcon, string.format("rouge_faction_smallicon_%s", slot4.id))
	end

	gohelper.setActive(slot0._gofaction, slot4 ~= nil)
end

function slot0.refreshTitle(slot0, slot1)
	slot4 = ""

	slot0._simagetitle:LoadImage((not string.nilorempty(RougeDLCHelper.versionListToString(slot1:getVersions())) or uv0.DefaultTitleImageUrl) and ResUrl.getRougeDLCLangImage("logo_dlc_" .. slot3))
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simagetitle:UnLoadImage()
end

return slot0
