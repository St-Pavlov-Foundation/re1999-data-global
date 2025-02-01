module("modules.logic.versionactivity1_2.yaxian.view.YaXianRewardView", package.seeall)

slot0 = class("YaXianRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btncloseview = gohelper.findChildButton(slot0.viewGO, "#btn_closeview")
	slot0._simageblackbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blackbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftbg")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._txttipsinfo = gohelper.findChildText(slot0.viewGO, "#go_tips/#txt_tipsinfo")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_reward")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_content")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom")
	slot0._gograyline = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom/#go_grayline")
	slot0._gonormalline = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom/#go_normalline")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom/#go_arrow")
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "#go_target")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "progresstip/#txt_progress")
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseview:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseviewOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.initTargetRewardItem(slot0)
	slot0.targetRewardItem = YaXianRewardItem.New(slot0:getResInst(slot0.itemPath, slot0.goTargetRewardItemContainer, "item"))

	slot0.targetRewardItem:init()
	slot0.targetRewardItem:show()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getYaXianImage("img_deco_zhizhuwang"))
	slot0._simageblackbg:LoadImage(ResUrl.getYaXianImage("img_tanchuang_bg"))

	slot0.progressIcon = gohelper.findChildImage(slot0.viewGO, "progresstip/icon")

	UISpriteSetMgr.instance:setYaXianSprite(slot0.progressIcon, "icon_zhanluedian_get")

	slot0.goTargetRewardItemContainer = gohelper.findChild(slot0.viewGO, "#go_target/#go_targetRewardItemContainer")
	slot0.contentTransform = slot0._gocontent.transform
	slot0.scrollWidth = recthelper.getWidth(slot0._scrollreward.transform)
	slot0.grayLineTransform = slot0._gograyline.transform
	slot0.normalLineTransform = slot0._gonormalline.transform
	slot0.arrowTransform = slot0._goarrow.transform
	slot0.itemPath = slot0.viewContainer:getSetting().otherRes[1]
	slot0.rewardItemList = {}
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollreward.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEndHandler, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._scrollreward.gameObject)

	slot0._touch:AddClickDownListener(slot0._onClickDownHandler, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._scrollreward.gameObject, DungeonMapEpisodeAudio, slot0._scrollreward)

	slot0:initTargetRewardItem()
	slot0._scrollreward:AddOnValueChanged(slot0.onValueChanged, slot0)
end

function slot0._onDragBeginHandler(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEndHandler(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDownHandler(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0.onValueChanged(slot0)
	slot0:refreshTargetRewardItem()
end

function slot0.onOpen(slot0)
	slot0._txtprogress.text = YaXianModel.instance:getScore()

	slot0:refreshItems()
	slot0:refreshContentWidth()
	slot0:refreshLineWidthAndArrowAnchor()
	slot0:refreshTargetRewardItem()
	TaskDispatcher.runDelay(slot0.senGetBonusRequest, slot0, 1)
end

function slot0.refreshItems(slot0)
	slot2, slot3 = nil

	for slot7, slot8 in ipairs(lua_activity115_bonus.configList) do
		if not slot0.rewardItemList[slot7] then
			slot2 = YaXianRewardItem.New(slot0:getResInst(slot0.itemPath, slot0._gobottom, "item" .. slot8.id))

			slot2:init()
			table.insert(slot0.rewardItemList, slot2)
		end

		slot2:update(slot7, slot8)
	end

	for slot7 = #slot1 + 1, #slot0.rewardItemList do
		slot0.rewardItemList[slot7]:hide()
	end
end

function slot0.refreshContentWidth(slot0)
	slot0.contentWidth = #lua_activity115_bonus.configList * (YaXianEnum.RewardEnum.RewardItemWidth + YaXianEnum.RewardEnum.IntervalX) + YaXianEnum.RewardEnum.RewardContentOffsetX

	recthelper.setWidth(slot0.contentTransform, slot0.contentWidth)
end

function slot0.calculateNormalWidth(slot0)
	slot0.normalLineWidth = 0
	slot1 = YaXianModel.instance:getScore()
	slot2 = false
	slot3 = 0

	for slot7, slot8 in ipairs(slot0.rewardItemList) do
		if slot1 < slot8.config.needScore then
			slot10 = slot0.rewardItemList[slot7 - 1] and slot9:getAnchorPosX() or 0
			slot11 = slot9 and slot9.config.needScore or 0
			slot0.normalLineWidth = slot10 + (slot1 - slot11) / (slot8.config.needScore - slot11) * (slot8:getAnchorPosX() - slot10)
			slot3 = slot7
			slot2 = true

			break
		end
	end

	if not slot2 then
		slot0.normalLineWidth = slot0.contentWidth
		slot3 = #slot0.rewardItemList
	end

	slot0._scrollreward.horizontalNormalizedPosition = (slot3 - 4) / (#slot0.rewardItemList - 4)
end

function slot0.refreshLineWidthAndArrowAnchor(slot0)
	slot0:calculateNormalWidth()
	recthelper.setWidth(slot0.grayLineTransform, slot0.contentWidth)
	recthelper.setWidth(slot0.normalLineTransform, slot0.normalLineWidth)
	recthelper.setAnchorX(slot0.arrowTransform, slot0.normalLineWidth)
end

function slot0.refreshTargetRewardItem(slot0)
	slot1 = slot0:getTargetRewardConfig()

	if slot0.targetRewardItem.config and slot0.targetRewardItem.config.id == slot1.id then
		return
	end

	slot0.targetRewardItem:updateByTarget(slot1)
end

function slot0.getTargetRewardConfig(slot0)
	for slot5, slot6 in ipairs(slot0.rewardItemList) do
		if slot6:isImportItem() and -(recthelper.getAnchorX(slot0.contentTransform) - slot0.scrollWidth - YaXianEnum.RewardEnum.HalfRewardItemWidth) <= slot6:getAnchorPosX() then
			return slot6.config
		end
	end

	for slot5 = #lua_activity115_bonus.configList, 1, -1 do
		if lua_activity115_bonus.configList[slot5].important ~= 0 then
			return slot6
		end
	end
end

function slot0.senGetBonusRequest(slot0)
	Activity115Rpc.instance:sendAct115BonusRequest()
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_insight_close)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageblackbg:UnLoadImage()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()

	slot0._drag = nil

	slot0._touch:RemoveClickDownListener()

	slot0._touch = nil

	for slot4, slot5 in ipairs(slot0.rewardItemList) do
		slot5:onDestroy()
	end

	slot0.targetRewardItem:onDestroy()
	slot0._scrollreward:RemoveOnValueChanged()

	slot0.rewardItemList = nil
end

return slot0
