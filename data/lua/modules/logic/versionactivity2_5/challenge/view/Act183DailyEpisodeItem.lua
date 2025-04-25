module("modules.logic.versionactivity2_5.challenge.view.Act183DailyEpisodeItem", package.seeall)

slot0 = class("Act183DailyEpisodeItem", Act183BaseEpisodeItem)
slot1 = {
	{
		-1.9,
		0,
		0,
		0,
		6.53
	},
	{
		0,
		0,
		0,
		0,
		0
	},
	{
		0,
		0,
		0,
		0,
		0
	}
}
slot2 = {
	{
		-8.76,
		-77.2,
		0,
		0,
		0
	},
	{
		112.7,
		-119.5,
		0,
		0,
		0
	},
	{
		124.6,
		-126.3,
		0,
		0,
		0
	}
}
slot3 = {
	{
		-163.3,
		79.5,
		0,
		0,
		10.13
	},
	{
		-173.3,
		100.8,
		0,
		0,
		5.01
	},
	{
		-166.4,
		92.9,
		0,
		0,
		1.42
	}
}
slot4 = {
	{
		122.1,
		110,
		0,
		0,
		0
	},
	{
		169.7,
		98.1,
		0,
		0,
		0
	},
	{
		153.1,
		110,
		0,
		0,
		0
	}
}

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._goinfo = gohelper.findChild(slot0.go, "Info")
	slot0._imagerule1 = gohelper.findChildImage(slot0.go, "Info/rules/image_rule1")
	slot0._gorepress1 = gohelper.findChild(slot0.go, "Info/rules/image_rule1/go_repress1")
	slot0._imagerule2 = gohelper.findChildImage(slot0.go, "Info/rules/image_rule2")
	slot0._gorepress2 = gohelper.findChild(slot0.go, "Info/rules/image_rule2/go_repress2")
	slot0._imageindex = gohelper.findChildImage(slot0.go, "go_finish/image_index")
	slot0._goescape1 = gohelper.findChild(slot0.go, "Info/rules/image_rule1/go_repressbutterfly1")
	slot0._goescape2 = gohelper.findChild(slot0.go, "Info/rules/image_rule2/go_repressbutterfly2")
	slot0._animrepress1 = gohelper.onceAddComponent(slot0._gorepress1, gohelper.Type_Animator)
	slot0._animrepress2 = gohelper.onceAddComponent(slot0._gorepress2, gohelper.Type_Animator)
	slot0._animescape1 = gohelper.onceAddComponent(slot0._goescape1, gohelper.Type_Animator)
	slot0._animescape2 = gohelper.onceAddComponent(slot0._goescape2, gohelper.Type_Animator)
end

function slot0.addEventListeners(slot0)
	uv0.super.addEventListeners(slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, slot0._onUpdateRepressInfo, slot0)
end

function slot0.removeEventListeners(slot0)
	uv0.super.removeEventListeners(slot0)
end

function slot0._onUpdateRepressInfo(slot0, slot1, slot2)
	if slot0._episodeId ~= slot1 then
		return
	end

	slot0:refreshRules()
end

function slot0.onUpdateMo(slot0, slot1)
	uv0.super.onUpdateMo(slot0, slot1)

	if slot0._status == Act183Enum.EpisodeStatus.Finished then
		UISpriteSetMgr.instance:setChallengeSprite(slot0._imageindex, "v2a5_challenge_dungeon_level_" .. slot1:getPassOrder())
	end

	slot0:refreshRules()
	slot0:setIconPositionAndRotation()
	slot0:setInfoPositionAndRotation()
	slot0:setIndexPositionAndRotation()
end

function slot0.refreshRules(slot0)
	Act183Helper.setRuleIcon(slot0._episodeId, 1, slot0._imagerule1)
	Act183Helper.setRuleIcon(slot0._episodeId, 2, slot0._imagerule2)

	slot0._rule1status = slot0._episodeMo:getRuleStatus(1)
	slot0._rule2status = slot0._episodeMo:getRuleStatus(2)

	gohelper.setActive(slot0._gorepress1, slot0._rule1status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(slot0._gorepress2, slot0._rule2status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(slot0._goescape1, slot0._rule1status == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(slot0._goescape2, slot0._rule2status == Act183Enum.RuleStatus.Escape)
end

function slot0.playFinishAnim(slot0)
	uv0.super.playFinishAnim(slot0)
	slot0:playRepressAnim()
end

function slot0.playRepressAnim(slot0)
	if slot0._rule1status == Act183Enum.RuleStatus.Repress then
		slot0._animrepress1:Play("in", 0, 0)
	else
		slot0._animescape1:Play("in", 0, 0)
	end

	if slot0._rule2status == Act183Enum.RuleStatus.Repress then
		slot0._animrepress2:Play("in", 0, 0)
	else
		slot0._animescape2:Play("in", 0, 0)
	end
end

function slot0.setIconPositionAndRotation(slot0)
	Act183Helper.setTranPositionAndRotation(slot0._episodeId, slot0:getConfigOrder(), uv0, slot0._simageicon.transform)
end

function slot0.setInfoPositionAndRotation(slot0)
	Act183Helper.setTranPositionAndRotation(slot0._episodeId, slot0:getConfigOrder(), uv0, slot0._goinfo.transform)
end

function slot0.setIndexPositionAndRotation(slot0)
	Act183Helper.setTranPositionAndRotation(slot0._episodeId, slot0:getConfigOrder(), uv0, slot0._imageindex.transform)
end

function slot0._getCheckIconPosAndRotConfig(slot0, slot1)
	return uv0 and uv0[slot1]
end

return slot0
