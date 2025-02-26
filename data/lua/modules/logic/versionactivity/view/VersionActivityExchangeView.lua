module("modules.logic.versionactivity.view.VersionActivityExchangeView", package.seeall)

slot0 = class("VersionActivityExchangeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gochat = gohelper.findChild(slot0.viewGO, "taklkarea/#go_chat")
	slot0._txttalk1 = gohelper.findChildText(slot0.viewGO, "taklkarea/#go_chat/#txt_talk1")
	slot0._txttalk2 = gohelper.findChildText(slot0.viewGO, "taklkarea/#go_chat/#txt_talk2")
	slot0._gohero1 = gohelper.findChild(slot0.viewGO, "taklkarea/hero1/#go_hero1")
	slot0._gohero2 = gohelper.findChild(slot0.viewGO, "taklkarea/hero2/#go_hero2")
	slot0._goroleimage = gohelper.findChild(slot0.viewGO, "taklkarea/#go_role_image")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#txt_deadline")
	slot0._txthas = gohelper.findChildText(slot0.viewGO, "gohas/#txt_has")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_reward")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_Content")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_Content/#go_rewardItem")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_Content/#go_rewardItem/#go_rewardcontent")
	slot0._btngetres = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_getres")
	slot0._btnrule = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rule")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._slider = gohelper.findChildSlider(slot0.viewGO, "#scroll_reward/Viewport/#go_Content/#slider_progress")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngetres:AddClickListener(slot0._btngetresOnClick, slot0)
	slot0._btnrule:AddClickListener(slot0.openTips, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngetres:RemoveClickListener()
	slot0._btnrule:RemoveClickListener()
end

function slot0._btngetresOnClick(slot0)
	if ActivityModel.instance:getActEndTime(slot0.actId) / 1000 - ServerTime.now() < tonumber(slot0._actMO.config.param) * 3600 then
		ToastController.instance:showToast(185)
	else
		ViewMgr.instance:openView(ViewName.VersionActivityExchangeTaskView, {
			actId = slot0.actId
		})
	end
end

function slot0.openTips(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivityTipsView)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorewardItem, false)

	slot0.rewardItemList = {}
	slot0.actId = 11114
	slot0._actMO = ActivityModel.instance:getActMO(slot0.actId)
	slot0._uiSpine1 = GuiModelAgentNew.Create(slot0._gohero1, true)
	slot0._uiSpine2 = GuiModelAgentNew.Create(slot0._gohero2, true)

	slot0._simagebg:LoadImage(ResUrl.getVersionActivityExchangeIcon("full/bg"))

	slot0._animator = gohelper.findChild(slot0.viewGO, "taklkarea"):GetComponent(typeof(UnityEngine.Animator))
	slot2 = ViewMgr.instance:getUIRoot().transform
	slot3 = recthelper.getHeight(slot2)
	slot4 = recthelper.getWidth(slot2)

	recthelper.setSize(gohelper.findChild(slot0._goroleimage, "maskhero1Shadow/img_hero1").transform, slot4, slot3)
	recthelper.setSize(gohelper.findChild(slot0._goroleimage, "maskhero2Shadow/img_hero2").transform, slot4, slot3)
	recthelper.setSize(gohelper.findChild(slot0._goroleimage, "maskhero1/img_hero1").transform, slot4, slot3)
	recthelper.setSize(gohelper.findChild(slot0._goroleimage, "maskhero2/img_hero2").transform, slot4, slot3)

	slot0.iconClick = gohelper.findChildClick(slot0.viewGO, "gohas/icon")

	slot0.iconClick:AddClickListener(slot0.onClickIcon, slot0)

	slot0._firstShow = true
	slot0._gotaskdot = gohelper.findChild(slot0.viewGO, "#btn_getres/dot")

	RedDotController.instance:addRedDot(slot0._gotaskdot, RedDotEnum.DotNode.VersionActivityExchangeTask)
end

function slot0.onClickIcon(slot0)
	MaterialTipController.instance:showMaterialInfo(1, 970002, false, nil, false)
end

function slot0.onUpdateParam(slot0)
	Activity112Rpc.instance:sendGet112InfosRequest(slot0.actId)
	slot0:refreshReward()
	slot0:updateItemNum()
	slot0:updateDeadline()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_paraphrase_open)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.updateItemNum, slot0)

	slot5 = slot0.refreshReward
	slot6 = slot0

	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112Update, slot5, slot6)
	Activity112Rpc.instance:sendGet112InfosRequest(slot0.actId)

	slot0._needList = {}

	for slot5, slot6 in ipairs(VersionActivityConfig.instance:getAct112Config(slot0.actId)) do
		slot0._needList[slot5] = string.splitToNumber(slot6.items, "#")[3]
	end

	slot0:updateItemNum()
	slot0:updateDeadline()
	TaskDispatcher.runRepeat(slot0.updateDeadline, slot0, 60)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.updateItemNum, slot0)
	slot0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112Update, slot0.refreshReward, slot0)
	TaskDispatcher.cancelTask(slot0.updateDeadline, slot0)
end

function slot0.removeEventCb(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItemList) do
		slot5:onDestroyView()
	end

	slot0.iconClick:RemoveClickListener()

	slot0.rewardItemList = nil

	slot0._simagebg:UnLoadImage()
end

function slot0.refreshReward(slot0)
	slot1 = VersionActivityConfig.instance:getAct112Config(slot0.actId)
	slot3 = (ServerTime.now() - ActivityModel.instance:getActStartTime(slot0.actId) / 1000) / 86400
	slot4 = nil

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, 0) == 0 then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, slot1[1].id)
	end

	slot6 = nil

	for slot10, slot11 in ipairs(slot1) do
		if slot0.rewardItemList[slot10] == nil then
			slot13 = gohelper.cloneInPlace(slot0._gorewardItem, "item" .. slot10)

			gohelper.setActive(slot13, true)

			slot12 = MonoHelper.addLuaComOnceToGo(slot13, VersionActivityExchangeItem, slot0)
			slot0.rewardItemList[slot10] = slot12

			slot12:setSelectFunc(slot0.onSelectItem, slot0)
		end

		if slot5 == slot11.id then
			slot6 = slot11
		end

		slot12:updateItem(slot11, slot10, slot0._firstShow)
		slot12:updateSelect(slot5)
	end

	slot0._firstShow = false

	if slot6 == nil then
		slot6 = slot1[1]
		slot5 = slot1[1].id

		slot0.rewardItemList[1]:updateSelect(slot5)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, slot5)
	end

	slot0.selectConfig = slot6

	slot0:updateSelectInfo()
end

function slot0.updateDeadline(slot0)
	slot0._txtdeadline.text = string.format(luaLang("activity_remain_time"), ActivityModel.instance:getActivityInfo()[slot0.actId]:getRemainTimeStr2ByEndTime())
end

function slot0.updateItemNum(slot0)
	slot0._txthas.text = ItemModel.instance:getItemQuantity(1, 970002)
	slot2 = 0
	slot3 = 0
	slot4 = 0
	slot5 = 0
	slot7 = 1 - 0.2
	slot8 = 0.1

	for slot12, slot13 in ipairs(slot0._needList) do
		if slot13 <= slot1 then
			slot2 = slot12
			slot3 = slot13
			slot4 = slot13
		elseif slot4 <= slot3 then
			slot4 = slot13
		end
	end

	if slot4 ~= slot3 then
		slot5 = (slot1 - slot3) / (slot4 - slot3)
	end

	if slot2 == 0 then
		slot0._slider:SetValue((slot8 + 0.3 * slot5) / (#slot0._needList - 0.5))
	else
		slot0._slider:SetValue((slot2 - 0.5 + slot8 + slot7 * slot5) / (#slot0._needList - 0.5))
	end

	for slot12, slot13 in ipairs(slot0.rewardItemList) do
		slot13:updateNeed()
	end
end

function slot0.onSelectItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.rewardItemList) do
		slot6:updateSelect(slot1.id)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, slot1.id)
	slot0._animator:Play(UIAnimationName.Click, 0, 0)

	slot0.selectConfig = slot1

	TaskDispatcher.cancelTask(slot0.updateSelectInfo, slot0)
	TaskDispatcher.runDelay(slot0.updateSelectInfo, slot0, 0.3)
end

function slot0.updateSelectInfo(slot0)
	slot1 = slot0.selectConfig
	slot0.state = VersionActivity112Model.instance:getRewardState(slot1.activityId, slot1.id)

	if slot0.state == 1 then
		slot0._txttalk1.text = slot1.themeDone
		slot0._txttalk2.text = slot1.themeDone2
	else
		slot0._txttalk1.text = slot1.theme
		slot0._txttalk2.text = slot1.theme2
	end

	gohelper.setActive(slot0._gochat, true)
	gohelper.setActive(slot0._goroleimage, false)
	transformhelper.setLocalScale(slot0._gohero1.transform, 1, 1, 1)
	transformhelper.setLocalScale(slot0._gohero2.transform, 1, 1, 1)
	slot0._uiSpine1:setResPath(slot1.skin, string.find(slot1.skin, "live2d"), slot0._onSpineLoaded1, slot0)
	slot0._uiSpine2:setResPath(slot1.skin2, string.find(slot1.skin2, "live2d"), slot0._onSpineLoaded2, slot0)
end

function slot0._onSpineLoaded1(slot0)
	gohelper.setActive(slot0._goroleimage, true)

	slot1 = string.splitToNumber(slot0.selectConfig.skinOffSet, "#")

	recthelper.setAnchor(slot0._gohero1.transform, slot1[1], slot1[2])
	transformhelper.setLocalScale(slot0._gohero1.transform, slot1[3], slot1[3], slot1[3])
end

function slot0._onSpineLoaded2(slot0)
	gohelper.setActive(slot0._goroleimage, true)

	slot1 = string.splitToNumber(slot0.selectConfig.skin2OffSet, "#")

	recthelper.setAnchor(slot0._gohero2.transform, slot1[1], slot1[2])
	transformhelper.setLocalScale(slot0._gohero2.transform, slot1[3], slot1[3], slot1[3])
end

return slot0
