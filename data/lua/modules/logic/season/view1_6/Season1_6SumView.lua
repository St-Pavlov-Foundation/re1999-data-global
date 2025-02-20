module("modules.logic.season.view1_6.Season1_6SumView", package.seeall)

slot0 = class("Season1_6SumView", BaseView)

function slot0.onInitView(slot0)
	slot0.anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_CloseMask")
	slot0._btnClose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Close")
	slot0.simagePanelBg1 = gohelper.findChildSingleImage(slot0.viewGO, "Root/BG/#simage_PanelBG1")
	slot0.simagePanelBg2 = gohelper.findChildSingleImage(slot0.viewGO, "Root/BG/#simage_PanelBG2")
	slot0.simagePanelBg3 = gohelper.findChildSingleImage(slot0.viewGO, "Root/BG/#simage_PanelBG3")
	slot0.mailRoot = gohelper.findChild(slot0.viewGO, "Root/1")
	slot0.mailTipsTxt = gohelper.findChildTextMesh(slot0.mailRoot, "Right/txt_Tips")
	slot0.mailDescTxt = gohelper.findChildTextMesh(slot0.mailRoot, "Right/Scroll View/Viewport/#txt_Descr")
	slot0.mailChapterTxt = gohelper.findChildTextMesh(slot0.mailRoot, "Right/Chapter/#txt_ChapterName")
	slot0.mailChapterEnTxt = gohelper.findChildTextMesh(slot0.mailRoot, "Right/Chapter/#txt_ChapterNameEn")
	slot0.mailChapterBg = gohelper.findChildImage(slot0.mailRoot, "Right/Chapter/image_ChapterPic")
	slot0.reviewRoot = gohelper.findChild(slot0.viewGO, "Root/2")
	slot0.reviewTitleTxt = gohelper.findChildTextMesh(slot0.reviewRoot, "Right/#txt_TitleName")
	slot0.reviewChapterGrid = gohelper.findChild(slot0.reviewRoot, "Right/Chapter/Grid")
	slot0.goChapterItem = gohelper.findChild(slot0.reviewChapterGrid, "goChapterItem")
	slot0.reviewCardGrid = gohelper.findChild(slot0.reviewRoot, "Right/Card/Grid")
	slot0.goCardItem = gohelper.findChild(slot0.reviewCardGrid, "goCardItem")
	slot0.cardItems = {}
	slot0.chapterItems = {}
	slot0.inMail = true

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnClose, slot0._onClickClose, slot0)
	slot0:addClickCb(slot0._btnClose2, slot0._onClickClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0._btnClose, slot0._onClickClose, slot0)
	slot0:removeClickCb(slot0._btnClose2, slot0._onClickClose, slot0)
end

function slot0._editableInitView(slot0)
	slot0.simagePanelBg1:LoadImage(SeasonViewHelper.getSeasonIcon("sum_bg.png"))
	slot0.simagePanelBg2:LoadImage(SeasonViewHelper.getSeasonIcon("sum_bg.png"))
	slot0.simagePanelBg3:LoadImage(SeasonViewHelper.getSeasonIcon("sum_frame.png"))
end

function slot0._onClickClose(slot0)
	if slot0.inMail then
		slot0:showReviewView(true)

		return
	end

	slot0:closeThis()
end

function slot0.onOpen(slot0)
	Activity104Rpc.instance:sendMarkPopSummaryRequest(Activity104Model.instance:getCurSeasonId())
	slot0:showMailView()
end

function slot0.showMailView(slot0)
	slot0.inMail = true

	gohelper.setActive(slot0.mailRoot, true)
	gohelper.setActive(slot0.reviewRoot, false)
	gohelper.setActive(slot0._btnClose2, false)

	if not Activity104Model.instance:getLastMaxLayer(Activity104Model.instance:getCurSeasonId()) or slot2 <= 0 then
		slot0:showReviewView()

		return
	end

	slot4 = SeasonConfig.instance:getSeasonConstCo(slot1, Activity104Enum.ConstEnum.LastSeasonId) and slot3.value1
	slot0.mailTipsTxt.text = formatLuaLang("season_review_mail_tips", ActivityConfig.instance:getActivityCo(slot4) and slot5.name or "")
	slot8 = SeasonConfig.instance:getSeasonConstCo(slot1, Activity104Enum.ConstEnum.SumMailLangKey) and slot7.value2
	slot0.mailDescTxt.text = slot8 and luaLang(slot8) or ""
	slot9 = SeasonConfig.instance:getSeasonEpisodeCo(slot4, slot2)
	slot0.mailChapterTxt.text = string.format("%s-%s", formatLuaLang("title_chapter", slot2), slot9.stageName)
	slot0.mailChapterEnTxt.text = slot9.stageNameEn

	UISpriteSetMgr.instance:setV1a6SeasonSumSprite(slot0.mailChapterBg, string.format("v1a6_season_sum_chapterpic%s", slot9.stage))
end

function slot0.showReviewView(slot0, slot1)
	slot0.inMail = false

	gohelper.setActive(slot0.reviewRoot, true)
	gohelper.setActive(slot0._btnClose2, true)

	if slot1 then
		slot0.anim:Play("switch")
		TaskDispatcher.runDelay(slot0.hideMail, slot0, 0.84)
	else
		gohelper.setActive(slot0.mailRoot, false)
	end

	slot6 = ActivityConfig.instance:getActivityCo(SeasonConfig.instance:getSeasonConstCo(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ConstEnum.LastSeasonId) and slot3.value1) and slot5.name or ""
	slot7 = GameUtil.utf8sub(slot6, 1, 1)
	slot8 = ""

	if GameUtil.utf8len(slot6) >= 2 then
		slot8 = GameUtil.utf8sub(slot6, 2, slot9 - 1)
	end

	slot0.reviewTitleTxt.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season_review"), {
		slot7,
		slot8
	})
	slot17 = #(GameUtil.splitString2(SeasonConfig.instance:getSeasonConstCo(slot2, Activity104Enum.ConstEnum.SumReviewChapter) and slot11.value2 or "", true) or {})

	for slot17 = 1, math.max(slot17, #slot0.chapterItems) do
		slot0:refreshChapter(slot17, slot13[slot17], #slot13)
	end

	slot20 = #string.splitToNumber(SeasonConfig.instance:getSeasonConstCo(slot2, Activity104Enum.ConstEnum.SumReviewCard) and slot14.value2 or "", "#")

	for slot20 = 1, math.max(slot20, #slot0.chapterItems) do
		slot0:refreshCard(slot20, slot16[slot20])
	end
end

function slot0.refreshChapter(slot0, slot1, slot2, slot3)
	if not slot0.chapterItems[slot1] then
		slot4 = slot0:getUserDataTb_()
		slot0.chapterItems[slot1] = slot4
		slot4.go = gohelper.cloneInPlace(slot0.goChapterItem, tostring(slot1))
		slot4.txtChapter = gohelper.findChildTextMesh(slot4.go, "#txt_ChapterNum")
		slot4.txtPer = gohelper.findChildTextMesh(slot4.go, "#txt_per")
		slot4.slider = gohelper.findChildSlider(slot4.go, "Slider")
		slot4.line1 = gohelper.findChild(slot4.go, "image_Line1")
		slot4.line2 = gohelper.findChild(slot4.go, "image_Line2")

		function slot4._setFaithPercent(slot0, slot1)
			slot0.txtPer.text = string.format("%d%%", slot1)

			slot0.slider:SetValue(slot1 * 0.01)
		end

		function slot4._setFaithValue(slot0)
			slot0:_setFaithPercent(slot0.data[2] or 0)

			if slot0._faithTweenId then
				ZProj.TweenHelper.KillById(slot0._faithTweenId)

				slot0._faithTweenId = nil
			end
		end
	end

	slot4.data = slot2

	if not slot2 then
		gohelper.setActive(slot4.go, false)

		return
	end

	gohelper.setActive(slot4.go, true)

	slot4.txtChapter.text = formatLuaLang("chapter", slot2[1])

	gohelper.setActive(slot4.line1, slot1 ~= 1)
	gohelper.setActive(slot4.line2, slot1 ~= 1)

	slot4._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, slot2[2] or 0, 1.2, slot4._setFaithPercent, slot4._setFaithValue, slot4, nil, EaseType.Linear)
end

function slot0.refreshCard(slot0, slot1, slot2)
	if not slot0.cardItems[slot1] then
		slot3 = slot0:getUserDataTb_()
		slot0.cardItems[slot1] = slot3
		slot3.go = gohelper.cloneInPlace(slot0.goCardItem, tostring(slot1))
		slot3.goCard = gohelper.findChild(slot3.go, "#go_seasoncelebritycarditem")
		slot3.txtIndex = gohelper.findChildTextMesh(slot3.go, "image_NumBG/txt_Num")
	end

	if not slot2 then
		gohelper.setActive(slot3.go, false)

		return
	end

	gohelper.setActive(slot3.go, true)

	slot3.txtIndex.text = tostring(slot1)

	if not slot3.cardItem then
		slot3.cardItem = Season1_6CelebrityCardItem.New()

		slot3.cardItem:init(slot3.goCard, slot2, {
			noClick = true
		})
	else
		slot3.cardItem:reset(slot2)
	end
end

function slot0.hideMail(slot0)
	gohelper.setActive(slot0.mailRoot, false)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.chapterItems) do
		if slot5._faithTweenId then
			ZProj.TweenHelper.KillById(slot5._faithTweenId)

			slot5._faithTweenId = nil
		end
	end

	slot0.simagePanelBg1:UnLoadImage()
	slot0.simagePanelBg2:UnLoadImage()
	slot0.simagePanelBg3:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.hideMail, slot0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.EnterSeasonMainView)
end

return slot0
