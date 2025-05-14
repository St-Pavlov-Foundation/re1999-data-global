module("modules.logic.season.view1_5.Season1_5SumView", package.seeall)

local var_0_0 = class("Season1_5SumView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_CloseMask")
	arg_1_0._btnClose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")
	arg_1_0.simagePanelBg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/BG/#simage_PanelBG1")
	arg_1_0.simagePanelBg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/BG/#simage_PanelBG2")
	arg_1_0.simagePanelBg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/BG/#simage_PanelBG3")
	arg_1_0.mailRoot = gohelper.findChild(arg_1_0.viewGO, "Root/1")
	arg_1_0.mailTipsTxt = gohelper.findChildTextMesh(arg_1_0.mailRoot, "Right/txt_Tips")
	arg_1_0.mailDescTxt = gohelper.findChildTextMesh(arg_1_0.mailRoot, "Right/Scroll View/Viewport/#txt_Descr")
	arg_1_0.mailChapterTxt = gohelper.findChildTextMesh(arg_1_0.mailRoot, "Right/Chapter/#txt_ChapterName")
	arg_1_0.mailChapterEnTxt = gohelper.findChildTextMesh(arg_1_0.mailRoot, "Right/Chapter/#txt_ChapterNameEn")
	arg_1_0.mailChapterBg = gohelper.findChildImage(arg_1_0.mailRoot, "Right/Chapter/image_ChapterPic")
	arg_1_0.reviewRoot = gohelper.findChild(arg_1_0.viewGO, "Root/2")
	arg_1_0.reviewTitleTxt = gohelper.findChildTextMesh(arg_1_0.reviewRoot, "Right/#txt_TitleName")
	arg_1_0.reviewChapterGrid = gohelper.findChild(arg_1_0.reviewRoot, "Right/Chapter/Grid")
	arg_1_0.goChapterItem = gohelper.findChild(arg_1_0.reviewChapterGrid, "goChapterItem")
	arg_1_0.reviewCardGrid = gohelper.findChild(arg_1_0.reviewRoot, "Right/Card/Grid")
	arg_1_0.goCardItem = gohelper.findChild(arg_1_0.reviewCardGrid, "goCardItem")
	arg_1_0.cardItems = {}
	arg_1_0.chapterItems = {}
	arg_1_0.inMail = true

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnClose, arg_2_0._onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnClose2, arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnClose, arg_3_0._onClickClose, arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnClose2, arg_3_0._onClickClose, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.simagePanelBg1:LoadImage("singlebg/v1a4_season_sum_singlebg/v1a4_season_sum_bg.png")
	arg_4_0.simagePanelBg2:LoadImage("singlebg/v1a4_season_sum_singlebg/v1a4_season_sum_bg.png")
	arg_4_0.simagePanelBg3:LoadImage("singlebg/v1a4_season_sum_singlebg/v1a4_season_sum_frame.png")
end

function var_0_0._onClickClose(arg_5_0)
	if arg_5_0.inMail then
		arg_5_0:showReviewView(true)

		return
	end

	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	Activity104Rpc.instance:sendMarkPopSummaryRequest(Activity104Model.instance:getCurSeasonId())
	arg_6_0:showMailView()
end

function var_0_0.showMailView(arg_7_0)
	arg_7_0.inMail = true

	gohelper.setActive(arg_7_0.mailRoot, true)
	gohelper.setActive(arg_7_0.reviewRoot, false)
	gohelper.setActive(arg_7_0._btnClose2, false)

	local var_7_0 = Activity104Model.instance:getCurSeasonId()
	local var_7_1 = Activity104Model.instance:getLastMaxLayer(var_7_0)

	if not var_7_1 or var_7_1 <= 0 then
		arg_7_0:showReviewView()

		return
	end

	local var_7_2 = SeasonConfig.instance:getSeasonConstCo(var_7_0, Activity104Enum.ConstEnum.LastSeasonId)
	local var_7_3 = var_7_2 and var_7_2.value1
	local var_7_4 = ActivityConfig.instance:getActivityCo(var_7_3)
	local var_7_5 = var_7_4 and var_7_4.name or ""

	arg_7_0.mailTipsTxt.text = formatLuaLang("season_review_mail_tips", var_7_5)

	local var_7_6 = SeasonConfig.instance:getSeasonConstCo(var_7_0, Activity104Enum.ConstEnum.SumMailLangKey)
	local var_7_7 = var_7_6 and var_7_6.value2

	arg_7_0.mailDescTxt.text = var_7_7 and luaLang(var_7_7) or ""

	local var_7_8 = SeasonConfig.instance:getSeasonEpisodeCo(var_7_3, var_7_1)

	arg_7_0.mailChapterTxt.text = string.format("%s-%s", formatLuaLang("title_chapter", var_7_1), var_7_8.stageName)
	arg_7_0.mailChapterEnTxt.text = var_7_8.stageNameEn

	UISpriteSetMgr.instance:setV1a4SeasonSumSprite(arg_7_0.mailChapterBg, string.format("v1a4_season_sum_chapterpic%s", var_7_8.stage))
end

function var_0_0.showReviewView(arg_8_0, arg_8_1)
	arg_8_0.inMail = false

	gohelper.setActive(arg_8_0.reviewRoot, true)
	gohelper.setActive(arg_8_0._btnClose2, true)

	if arg_8_1 then
		arg_8_0.anim:Play("switch")
		TaskDispatcher.runDelay(arg_8_0.hideMail, arg_8_0, 0.84)
	else
		gohelper.setActive(arg_8_0.mailRoot, false)
	end

	local var_8_0 = Activity104Model.instance:getCurSeasonId()
	local var_8_1 = SeasonConfig.instance:getSeasonConstCo(var_8_0, Activity104Enum.ConstEnum.LastSeasonId)
	local var_8_2 = var_8_1 and var_8_1.value1
	local var_8_3 = ActivityConfig.instance:getActivityCo(var_8_2)
	local var_8_4 = var_8_3 and var_8_3.name or ""
	local var_8_5 = GameUtil.utf8sub(var_8_4, 1, 1)
	local var_8_6 = ""
	local var_8_7 = GameUtil.utf8len(var_8_4)

	if var_8_7 >= 2 then
		var_8_6 = GameUtil.utf8sub(var_8_4, 2, var_8_7 - 1)
	end

	local var_8_8 = {
		var_8_5,
		var_8_6
	}

	arg_8_0.reviewTitleTxt.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season_review"), var_8_8)

	local var_8_9 = SeasonConfig.instance:getSeasonConstCo(var_8_0, Activity104Enum.ConstEnum.SumReviewChapter)
	local var_8_10 = var_8_9 and var_8_9.value2 or ""
	local var_8_11 = GameUtil.splitString2(var_8_10, true) or {}

	for iter_8_0 = 1, math.max(#var_8_11, #arg_8_0.chapterItems) do
		arg_8_0:refreshChapter(iter_8_0, var_8_11[iter_8_0], #var_8_11)
	end

	local var_8_12 = SeasonConfig.instance:getSeasonConstCo(var_8_0, Activity104Enum.ConstEnum.SumReviewCard)
	local var_8_13 = var_8_12 and var_8_12.value2 or ""
	local var_8_14 = string.splitToNumber(var_8_13, "#")

	for iter_8_1 = 1, math.max(#var_8_14, #arg_8_0.chapterItems) do
		arg_8_0:refreshCard(iter_8_1, var_8_14[iter_8_1])
	end
end

function var_0_0.refreshChapter(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0.chapterItems[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:getUserDataTb_()
		arg_9_0.chapterItems[arg_9_1] = var_9_0
		var_9_0.go = gohelper.cloneInPlace(arg_9_0.goChapterItem, tostring(arg_9_1))
		var_9_0.txtChapter = gohelper.findChildTextMesh(var_9_0.go, "#txt_ChapterNum")
		var_9_0.txtPer = gohelper.findChildTextMesh(var_9_0.go, "#txt_per")
		var_9_0.slider = gohelper.findChildSlider(var_9_0.go, "Slider")
		var_9_0.line1 = gohelper.findChild(var_9_0.go, "image_Line1")
		var_9_0.line2 = gohelper.findChild(var_9_0.go, "image_Line2")

		function var_9_0._setFaithPercent(arg_10_0, arg_10_1)
			arg_10_0.txtPer.text = string.format("%d%%", arg_10_1)

			arg_10_0.slider:SetValue(arg_10_1 * 0.01)
		end

		function var_9_0._setFaithValue(arg_11_0)
			arg_11_0:_setFaithPercent(arg_11_0.data[2] or 0)

			if arg_11_0._faithTweenId then
				ZProj.TweenHelper.KillById(arg_11_0._faithTweenId)

				arg_11_0._faithTweenId = nil
			end
		end
	end

	var_9_0.data = arg_9_2

	if not arg_9_2 then
		gohelper.setActive(var_9_0.go, false)

		return
	end

	gohelper.setActive(var_9_0.go, true)

	var_9_0.txtChapter.text = formatLuaLang("chapter", arg_9_2[1])

	local var_9_1 = arg_9_2[2] or 0

	gohelper.setActive(var_9_0.line1, arg_9_1 ~= 1)
	gohelper.setActive(var_9_0.line2, arg_9_1 ~= 1)

	var_9_0._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, var_9_1, 1.2, var_9_0._setFaithPercent, var_9_0._setFaithValue, var_9_0, nil, EaseType.Linear)
end

function var_0_0.refreshCard(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.cardItems[arg_12_1]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()
		arg_12_0.cardItems[arg_12_1] = var_12_0
		var_12_0.go = gohelper.cloneInPlace(arg_12_0.goCardItem, tostring(arg_12_1))
		var_12_0.goCard = gohelper.findChild(var_12_0.go, "#go_seasoncelebritycarditem")
		var_12_0.txtIndex = gohelper.findChildTextMesh(var_12_0.go, "image_NumBG/txt_Num")
	end

	if not arg_12_2 then
		gohelper.setActive(var_12_0.go, false)

		return
	end

	gohelper.setActive(var_12_0.go, true)

	var_12_0.txtIndex.text = tostring(arg_12_1)

	if not var_12_0.cardItem then
		var_12_0.cardItem = Season1_5CelebrityCardItem.New()

		var_12_0.cardItem:init(var_12_0.goCard, arg_12_2, {
			noClick = true
		})
	else
		var_12_0.cardItem:reset(arg_12_2)
	end
end

function var_0_0.hideMail(arg_13_0)
	gohelper.setActive(arg_13_0.mailRoot, false)
end

function var_0_0.onDestroyView(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.chapterItems) do
		if iter_14_1._faithTweenId then
			ZProj.TweenHelper.KillById(iter_14_1._faithTweenId)

			iter_14_1._faithTweenId = nil
		end
	end

	arg_14_0.simagePanelBg1:UnLoadImage()
	arg_14_0.simagePanelBg2:UnLoadImage()
	arg_14_0.simagePanelBg3:UnLoadImage()
	TaskDispatcher.cancelTask(arg_14_0.hideMail, arg_14_0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.EnterSeasonMainView)
end

return var_0_0
