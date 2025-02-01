module("modules.logic.seasonver.act166.view.Season166TeachView", package.seeall)

slot0 = class("Season166TeachView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btncloseReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeReward")
	slot0._goteachContent = gohelper.findChild(slot0.viewGO, "#go_teachContent")
	slot0._goteachItem = gohelper.findChild(slot0.viewGO, "#go_teachContent/#go_teachItem")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#go_rewardContent")
	slot0._gorewardWindow = gohelper.findChild(slot0.viewGO, "#go_rewardContent/#go_rewardWindow")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "#go_rewardContent/#go_rewardWindow/#go_rewardItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseReward:AddClickListener(slot0._btncloseRewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseReward:RemoveClickListener()
end

function slot0._btncloseRewardOnClick(slot0)
	for slot4, slot5 in pairs(slot0.rewardWindowTab) do
		gohelper.setActive(slot5.window, false)

		slot5.isShow = false
	end
end

function slot0._btnRewardOnClick(slot0, slot1)
	for slot5, slot6 in pairs(slot0.rewardWindowTab) do
		if slot5 == slot1 then
			slot6.isShow = not slot6.isShow
		else
			slot6.isShow = false
		end

		gohelper.setActive(slot6.window, slot6.isShow)
	end
end

function slot0._btnTeachItemOnClick(slot0, slot1)
	slot0:_btncloseRewardOnClick()

	slot3 = slot0.Season166MO.teachInfoMap[slot1.preTeachId]

	if not slot0.Season166MO.teachInfoMap[slot1.teachId] or not (slot1.preTeachId == 0 or slot1.preTeachId > 0 and slot3 and slot3.passCount > 0) then
		GameFacade.showToast(ToastEnum.Season166TeachLock)
	else
		slot5 = slot1.episodeId
		slot7 = slot1.teachId

		Season166TeachModel.instance:initTeachData(slot0.actId, slot7)
		Season166Model.instance:setBattleContext(slot0.actId, slot5, nil, 0, nil, slot7)
		DungeonFightController.instance:enterSeasonFight(DungeonConfig.instance:getEpisodeCO(slot5).chapterId, slot5)
	end
end

function slot0._editableInitView(slot0)
	slot0.teachItemTab = slot0:getUserDataTb_()
	slot0.rewardWindowTab = slot0:getUserDataTb_()
	slot0.localUnlockStateTab = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goteachItem, false)
	gohelper.setActive(slot0._gorewardWindow, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_shiji_tv_noise)
	slot0:createTeachItem()
	slot0:createRewardItem()
	slot0:refreshTeachItem()
end

function slot0.createTeachItem(slot0)
	for slot5, slot6 in ipairs(Season166Config.instance:getAllSeasonTeachCos()) do
		if not slot0.teachItemTab[slot6.teachId] then
			slot7 = {
				config = slot6,
				pos = gohelper.findChild(slot0._goteachContent, "go_teachPos" .. slot5)
			}
			slot7.item = gohelper.clone(slot0._goteachItem, slot7.pos, "teachItem" .. slot5)
			slot7.imageIndex = gohelper.findChildImage(slot7.item, "title/image_index")
			slot7.txtName = gohelper.findChildText(slot7.item, "title/txt_name")
			slot7.imageIcon = gohelper.findChildImage(slot7.item, "image_icon")
			slot7.txtDesc = gohelper.findChildText(slot7.item, "desc/txt_desc")
			slot7.goLock = gohelper.findChild(slot7.item, "go_lock")
			slot7.goFinish = gohelper.findChild(slot7.item, "go_finish")
			slot7.btnReward = gohelper.findChildButtonWithAudio(slot7.item, "btn_reward")
			slot7.btnClick = gohelper.findChildButtonWithAudio(slot7.item, "btn_click")

			slot7.btnReward:AddClickListener(slot0._btnRewardOnClick, slot0, slot7.config.teachId)
			slot7.btnClick:AddClickListener(slot0._btnTeachItemOnClick, slot0, slot7.config)

			slot7.anim = slot7.item:GetComponent(gohelper.Type_Animator)
			slot0.teachItemTab[slot6.teachId] = slot7
		end

		gohelper.setActive(slot7.item, true)
		UISpriteSetMgr.instance:setSeason166Sprite(slot7.imageIndex, "season_teach_num" .. slot5, true)

		slot7.txtName.text = slot6.name
		slot7.txtDesc.text = slot6.desc
	end
end

function slot0.createRewardItem(slot0)
	for slot5, slot6 in ipairs(Season166Config.instance:getAllSeasonTeachCos()) do
		if not slot0.rewardWindowTab[slot6.teachId] then
			slot7 = {
				pos = gohelper.findChild(slot0._gorewardContent, "go_rewardPos" .. slot5)
			}
			slot7.window = gohelper.clone(slot0._gorewardWindow, slot7.pos, "rewardWindow" .. slot5)
			slot7.rewardItem = gohelper.findChild(slot7.window, "#go_rewardItem")
			slot7.isShow = false
			slot7.rewardList = slot0:getUserDataTb_()
			slot0.rewardWindowTab[slot6.teachId] = slot7
		end

		gohelper.setActive(slot7.window, true)
		gohelper.setActive(slot7.rewardItem, false)

		for slot12, slot13 in ipairs(string.split(slot6.firstBonus, "|")) do
			if not slot7.rewardList[slot12] then
				slot14 = {
					rewardItem = gohelper.clone(slot7.rewardItem, slot7.window, "rewardItem" .. slot12)
				}
				slot14.itemPos = gohelper.findChild(slot14.rewardItem, "go_rewardItemPos")
				slot14.goGet = gohelper.findChild(slot14.rewardItem, "go_get")
				slot14.item = IconMgr.instance:getCommonPropItemIcon(slot14.itemPos)
				slot7.rewardList[slot12] = slot14
			end

			gohelper.setActive(slot14.rewardItem, true)

			slot15 = string.splitToNumber(slot13, "#")

			slot14.item:setMOValue(slot15[1], slot15[2], slot15[3])
			slot14.item:setHideLvAndBreakFlag(true)
			slot14.item:hideEquipLvAndBreak(true)
			slot14.item:setCountFontSize(51)
		end

		for slot12 = #slot8 + 1, #slot7.rewardList do
			gohelper.setActive(slot7.rewardList[slot12].rewardItem, false)
		end
	end
end

function slot0.refreshTeachItem(slot0)
	slot0.Season166MO = Season166Model.instance:getActInfo(slot0.actId)
	slot1 = Season166Model.instance:getLocalUnlockState(Season166Enum.TeachLockSaveKey)

	for slot5, slot6 in pairs(slot0.teachItemTab) do
		slot7 = slot6.config
		slot8 = slot0.Season166MO.teachInfoMap[slot7.teachId]
		slot9 = slot0.Season166MO.teachInfoMap[slot7.preTeachId]

		gohelper.setActive(slot6.goLock, not slot8 or not (slot7.preTeachId == 0 or slot7.preTeachId > 0 and slot9 and slot9.passCount > 0))
		gohelper.setActive(slot6.goFinish, slot8 and slot8.passCount > 0)

		for slot18, slot19 in pairs(slot0.rewardWindowTab[slot7.teachId].rewardList) do
			gohelper.setActive(slot19.goGet, slot12)
		end

		gohelper.setActive(slot13.window, slot13.isShow)
		UISpriteSetMgr.instance:setSeason166Sprite(slot6.imageIcon, slot11 and string.format("season_teach_lv%d_locked", slot5) or string.format("season_teach_lv%d", slot5), true)

		slot6.isLock = slot11 and Season166Enum.LockState or Season166Enum.UnlockState

		if not slot11 and (not slot1[slot5] or slot1[slot5] == Season166Enum.LockState) then
			slot6.anim:Play(UIAnimationName.Unlock, 0, 0)
		end
	end

	slot0:saveUnlockState()
end

function slot0.saveUnlockState(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.teachItemTab) do
		table.insert(slot1, string.format("%s|%s", slot5, slot6.isLock))
	end

	Season166Controller.instance:savePlayerPrefs(Season166Enum.TeachLockSaveKey, cjson.encode(slot1))
end

function slot0.onClose(slot0)
	slot0:saveUnlockState()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.teachItemTab) do
		slot5.btnReward:RemoveClickListener()
		slot5.btnClick:RemoveClickListener()
	end
end

return slot0
