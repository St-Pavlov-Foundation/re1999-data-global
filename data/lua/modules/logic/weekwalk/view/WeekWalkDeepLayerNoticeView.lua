module("modules.logic.weekwalk.view.WeekWalkDeepLayerNoticeView", package.seeall)

slot0 = class("WeekWalkDeepLayerNoticeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._txtlastprogress = gohelper.findChildText(slot0.viewGO, "rule/#txt_lastprogress")
	slot0._imageruleicon = gohelper.findChildImage(slot0.viewGO, "rule/ruleinfo/#image_ruleicon")
	slot0._imageruletag = gohelper.findChildImage(slot0.viewGO, "rule/ruleinfo/#image_ruletag")
	slot0._txtruledesc = gohelper.findChildText(slot0.viewGO, "rule/ruleinfo/#txt_ruledesc")
	slot0._simageruledescicon = gohelper.findChildSingleImage(slot0.viewGO, "rule/ruleinfo/mask/#simage_ruledescicon")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "rewards/#scroll_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "rewards/#scroll_rewards/Viewport/Content/#go_rewarditem")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "rewards/#btn_start")
	slot0._btnruledetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "rule/ruleinfo/#btn_ruledetail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnruledetail:AddClickListener(slot0._btnruledetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnruledetail:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnstartOnClick(slot0)
	slot0:openWeekWalkView()
end

function slot0._btnruledetailOnClick(slot0)
	WeekWalkController.instance:openWeekWalkRuleView()
end

function slot0.openWeekWalkView(slot0)
	module_views_preloader.WeekWalkLayerViewPreload(function ()
		uv0:delayOpenWeekWalkView()
	end)
end

function slot0.delayOpenWeekWalkView(slot0)
	slot0:closeThis()
	WeekWalkController.instance:openWeekWalkLayerView()
end

function slot0._editableInitView(slot0)
	slot0._info = WeekWalkModel.instance:getInfo()

	if slot0._info.isPopDeepSettle then
		slot0._info.isPopDeepSettle = false

		WeekwalkRpc.instance:sendMarkPopDeepSettleRequest()
	end

	slot0._simagebg1:LoadImage(ResUrl.getWeekWalkBg("full/beijing_shen.jpg"))
	slot0._simagemask:LoadImage(ResUrl.getWeekWalkBg("zhezhao.png"))
	slot0._simagebg2:LoadImage(ResUrl.getWeekWalkBg("shenmian_tcdi.png"))
end

function slot0.onUpdateParam(slot0)
end

function slot0._getRewardList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_task_weekwalk.configList) do
		if slot6.minTypeId == 4 and WeekWalkTaskListModel.instance:checkPeriods(slot6) then
			slot11 = "#"

			for slot11, slot12 in ipairs(GameUtil.splitString2(slot6.bonus, true, "|", slot11)) do
				slot15 = slot12[3]

				if not slot1[string.format("%s_%s", slot12[1], slot12[2])] then
					slot1[slot16] = slot12
				else
					slot17[3] = slot17[3] + slot15
					slot1[slot16] = slot17
				end
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, slot7)
	end

	table.sort(slot2, DungeonWeekWalkView._sort)

	return slot2
end

function slot0._showRewardList(slot0)
	for slot5, slot6 in ipairs(slot0:_getRewardList()) do
		slot7 = gohelper.cloneInPlace(slot0._gorewarditem)

		gohelper.setActive(slot7, true)

		slot8 = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot7, "go_item"))

		slot8:setMOValue(slot6[1], slot6[2], slot6[3])
		slot8:isShowCount(true)
		slot8:setCountFontSize(31)
	end
end

function slot0.onOpen(slot0)
	if slot0.viewParam and slot0.viewParam.openFromGuide then
		gohelper.findChildText(slot0.viewGO, "rule/resettip").text = luaLang("p_weekwalkdeeplayernoticeview_title_open")

		recthelper.setAnchorY(gohelper.findChild(slot0.viewGO, "rewards").transform, -208)
		gohelper.setActive(slot0._txtlastprogress, false)
	end

	slot3 = string.splitToNumber(slot0._info.deepProgress, "#")
	slot5 = slot3[2]

	if slot3[1] and slot5 then
		slot0._txtlastprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkdeeplayernoticeview_lastprogress"), {
			lua_weekwalk_scene.configDict[lua_weekwalk.configDict[slot4].sceneId].name,
			"0" .. (slot5 or 1)
		})
	else
		slot0._txtlastprogress.text = luaLang("weekwalkdeeplayernoticeview_noprogress")
	end

	slot0:_showRewardList()

	slot9 = nil
	slot9 = (not (lua_weekwalk_rule.configDict[slot0._info.issueId].isCn == 1) or ResUrl.getWeekWalkIconLangPath(slot7.icon)) and ResUrl.getWeekWalkBg("rule/" .. slot7.icon .. ".png")

	slot0._simageruledescicon:LoadImage(ResUrl.getWeekWalkBg("rule/" .. slot7.icon .. ".png"))

	if string.nilorempty(slot7.additionRule) then
		return
	end

	slot15 = "#"
	slot11 = GameUtil.splitString2(slot10, true, "|", slot15)
	slot0._ruleList = slot11

	for slot15, slot16 in ipairs(slot11) do
		slot0:_setRuleDescItem(lua_rule.configDict[slot16[2]], slot16[1])

		break
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_installation_open)
end

function slot0._setRuleDescItem(slot0, slot1, slot2)
	slot3 = {
		"#6384E5",
		"#D05B4C",
		"#C7b376"
	}

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot0._imageruleicon, slot1.icon)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imageruletag, "wz_" .. slot2)

	slot0._txtruledesc.text = formatLuaLang("fight_rule_desc", slot3[slot2], luaLang("dungeon_add_rule_target_" .. slot2), string.gsub(slot1.desc, "%【(.-)%】", "<color=#FF906A>[%1]</color>") .. ("\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(slot1.desc, slot3[1])))
end

function slot0.onClose(slot0)
	slot0._simageruledescicon:UnLoadImage()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_close)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
