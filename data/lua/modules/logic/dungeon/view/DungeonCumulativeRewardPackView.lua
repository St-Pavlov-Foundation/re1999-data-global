module("modules.logic.dungeon.view.DungeonCumulativeRewardPackView", package.seeall)

slot0 = class("DungeonCumulativeRewardPackView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "#txt_progress")
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "go_progress/#image_point")
	slot0._imagenormalright = gohelper.findChildImage(slot0.viewGO, "go_progress/#image_normal_right")
	slot0._imagenormalleft = gohelper.findChildImage(slot0.viewGO, "go_progress/#image_normal_left")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_rewards")
	slot0._gorewardtemplate = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_reward_template")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._txttipsinfo = gohelper.findChildText(slot0.viewGO, "#go_tips/#txt_tipsinfo")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_rightbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getDungeonIcon("full/guankajianlibiejing_038"))
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._txttitlecn = gohelper.findChildText(slot0.viewGO, "titlecn")
	slot0._txttitleen = gohelper.findChildText(slot0.viewGO, "titlecn/titleen")
end

function slot0.onUpdateParam(slot0)
end

function slot0._getPointRewardRequest(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		return
	end

	if DungeonMapModel.instance:canGetRewards(slot0._chapterId) and #slot1 > 0 then
		DungeonRpc.instance:sendGetPointRewardRequest(slot1)
	end
end

function slot0.onOpen(slot0)
	slot0._chapterId = slot0.viewParam.chapterId

	if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		TaskDispatcher.runDelay(slot0._getPointRewardRequest, slot0, 0.6)
	end

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)

	slot0._pointRewardCfg = DungeonConfig.instance:getChapterPointReward(slot0._chapterId)
	slot0._pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo(slot0._chapterId)

	if #slot0._pointRewardCfg > 0 then
		slot0._lastPointRewardCfg = slot0._pointRewardCfg[slot1]
	end

	slot2 = DungeonConfig.instance:getChapterCO(slot0._chapterId)
	slot0._txttitlecn.text = slot2.name
	slot0._txttitleen.text = slot2.name_En

	slot0:createRewardUIs()
	slot0:refreshRewardItems()
	slot0:refreshUnlockCondition()
	slot0:refreshProgress()
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnGetPointReward, slot0.refreshRewardItems, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.GuideGetPointReward, slot0._getPointRewardRequest, slot0)
end

function slot0.createRewardUIs(slot0)
	slot1 = slot0._pointRewardCfg
	slot2 = slot0._pointRewardInfo
	slot3 = slot0._lastPointRewardCfg

	if slot0._isInitItems or not slot3 then
		return
	end

	slot0._isInitItems = true
	slot0._rewarditems = {}

	for slot8 = 1, #string.split(slot3.reward, "|") do
		slot9 = string.splitToNumber(slot4[slot8], "#")
		slot10 = slot0:getUserDataTb_()
		slot11 = gohelper.clone(slot0._gorewardtemplate, slot0._gorewards, "reward_" .. tostring(slot8))
		slot10.imagebg = gohelper.findChildImage(slot11, "image_bg")
		slot10.simagereward = gohelper.findChildSingleImage(slot11, "simage_reward")
		slot10.txtrewardcount = gohelper.findChildText(slot11, "txt_rewardcount")
		slot10.imagereward = slot10.simagereward:GetComponent(gohelper.Type_Image)
		slot10.btn = gohelper.findChildClick(slot11, "simage_reward")
		slot10.goalreadygot = gohelper.findChild(slot11, "go_hasget")

		slot10.btn:AddClickListener(slot0.onClickItem, slot0, slot10)

		slot10.go = slot11
		slot10.rewardCfg = slot9
		slot10.itemCfg, slot10.iconPath = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2])

		gohelper.setActive(slot10.go, true)
		table.insert(slot0._rewarditems, slot10)
	end
end

function slot0.refreshRewardItems(slot0)
	for slot6, slot7 in ipairs(slot0._rewarditems) do
		slot0:refreshRewardUIItem(slot7, slot0._lastPointRewardCfg, slot0._pointRewardInfo)
	end
end

slot1 = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
slot2 = Color.New(1, 1, 1, 1)
slot3 = Color.New(1, 1, 1, 0.5)
slot4 = Color.New(1, 1, 1, 1)
slot5 = Color.New(0.227451, 0.227451, 0.227451, 1)
slot6 = Color.New(0.227451, 0.227451, 0.227451, 1)

function slot0.refreshRewardUIItem(slot0, slot1, slot2, slot3)
	slot1.imagereward.color = tabletool.indexOf(slot3.hasGetPointRewardIds, slot2.id) and uv0 or uv1
	slot1.imagebg.color = slot4 and uv2 or uv3
	slot1.txtrewardcount.color = slot4 and uv4 or uv5

	slot1.simagereward:LoadImage(slot1.iconPath)

	slot1.txtrewardcount.text = tostring(slot1.rewardCfg[3])

	gohelper.setActive(slot1.goalreadygot, slot4)
end

function slot0.onClickItem(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(slot1.rewardCfg[1], slot1.rewardCfg[2])
end

function slot0.refreshUnlockCondition(slot0)
	if not DungeonConfig.instance:getUnlockChapterConfig(slot0._chapterId) then
		gohelper.setActive(slot0._gotips, false)

		return
	end

	gohelper.setActive(slot0._gotips, true)

	slot2, slot3 = DungeonMapModel.instance:getTotalRewardPointProgress(slot0._chapterId)
	slot0._txttipsinfo.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeoncumulativerewardsview_tips"), {
		tostring(slot3),
		slot1.name
	})
end

function slot0.refreshProgress(slot0)
	slot1, slot2 = DungeonMapModel.instance:getTotalRewardPointProgress(slot0._chapterId)
	slot0._txtprogress.text = string.format("%s/%s", slot1, slot2)
	slot4 = slot1 / slot2
	slot0._imagenormalleft.fillAmount = slot4
	slot0._imagenormalright.fillAmount = slot4

	UISpriteSetMgr.instance:setUiFBSprite(slot0._imagepoint, slot0._lastPointRewardCfg.rewardPointNum <= slot0._pointRewardInfo.rewardPoint and "xingjidian_dian2_005" or "xingjidian_dian1_004")
end

function slot0.onClose(slot0)
	if slot0._isInitItems then
		for slot4, slot5 in pairs(slot0._rewarditems) do
			slot5.btn:RemoveClickListener()
			slot5.simagereward:UnLoadImage()
		end
	end

	TaskDispatcher.cancelTask(slot0._getPointRewardRequest, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
end

return slot0
