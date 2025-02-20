module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryRewardItem", package.seeall)

slot0 = class("Activity165StoryRewardItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._goreward = gohelper.findChild(slot0.viewGO, "#go_reward")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0._editableInitView(slot0)
	slot0._rewarditems = {}
	slot0._rewardGoPrefabs = gohelper.findChild(slot0.viewGO, "layout/go_reward")
	slot0._godarkpoint = gohelper.findChild(slot0.viewGO, "darkpoint")
	slot0._golightpoint = gohelper.findChild(slot0.viewGO, "lightpoint")
	slot0._golayout = gohelper.findChild(slot0.viewGO, "layout")
end

function slot0.onUpdateParam(slot0, slot1, slot2)
	slot0._storyId = slot2.storyId
	slot0._actId = Activity165Model.instance:getActivityId()
	slot8 = slot0._storyId
	slot0._storyMo = Activity165Model.instance:getStoryMo(slot0._actId, slot8)
	slot0._index = slot1

	for slot8 = 1, #DungeonConfig.instance:getRewardItems(tonumber(slot2.bonus)) do
		slot9 = slot3[slot8]
		slot10 = slot0:getRewardItem(slot8)

		slot0:onRefreshItem(slot1, slot8)
		gohelper.setActive(slot10.go, true)

		slot10.rewardCfg = slot9
		slot10.itemCfg, slot10.iconPath = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2])

		slot10.simagereward:LoadImage(slot10.iconPath)
		UISpriteSetMgr.instance:setUiFBSprite(slot10.imagebg, "bg_pinjidi_" .. slot10.itemCfg.rare)

		slot10.txtpointvalue.text = luaLang("multiple") .. slot9[3]
	end

	gohelper.setActive(slot0.viewGO, true)
end

function slot0.getRewardItem(slot0, slot1)
	if not slot0._rewarditems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.clone(slot0._rewardGoPrefabs, slot0._golayout, "reward_" .. tostring(slot1))
		slot2.imagebg = gohelper.findChildImage(slot3, "item/image_rare")
		slot2.simagereward = gohelper.findChildSingleImage(slot3, "item/simage_icon")
		slot2.txtpointvalue = gohelper.findChildText(slot3, "item/txt_num")
		slot2.imagereward = slot2.simagereward:GetComponent(gohelper.Type_Image)
		slot2.btn = gohelper.findChildButtonWithAudio(slot3, "item/btn_click")
		slot2.goalreadygot = gohelper.findChild(slot3, "go_hasget")
		slot2.btncanget = gohelper.findChildButtonWithAudio(slot3, "go_canget")

		slot2.btn:AddClickListener(slot0.onClickItem, slot0, slot2)

		slot2.go = slot3
		slot0._rewarditems[slot1] = slot2
	end

	return slot2
end

function slot0.onRefreshItem(slot0, slot1, slot2)
	if not slot0._storyMo then
		return
	end

	slot3 = slot0:getRewardItem(slot2)
	slot3.hasGetBonus = slot1 <= (slot0._storyMo:getclaimRewardCount() or 0)
	slot3.unlock = slot1 <= (slot0._storyMo:getUnlockEndingCount() or 0)
	slot3.canGetBonus = slot3.unlock and not slot3.hasGetBonus

	gohelper.setActive(slot3.goalreadygot, slot3.hasGetBonus)
	gohelper.setActive(slot3.btncanget.gameObject, slot3.canGetBonus)
	gohelper.setActive(slot0._godarkpoint, not slot3.unlock)
	gohelper.setActive(slot0._golightpoint.gameObject, slot3.unlock)
end

function slot0.onClickItem(slot0, slot1)
	MaterialTipController.instance:showMaterialInfo(slot1.rewardCfg[1], slot1.rewardCfg[2])
end

function slot0.checkBonus(slot0)
	if not slot0._storyMo then
		return
	end

	slot4 = false

	for slot8 = 1, #slot0._storyMo:getAllEndingRewardCo() do
		if slot8 <= slot0._storyMo:getUnlockEndingCount() and slot8 > slot0._storyMo:getclaimRewardCount() then
			slot4 = true

			break
		end
	end

	if slot4 then
		TaskDispatcher.runDelay(slot0.onGetBonusCallback, slot0, 0.5)
	end
end

function slot0.onGetBonusCallback(slot0)
	Activity165Rpc.instance:sendAct165GainMilestoneRewardRequest(slot0._actId, slot0._storyId)
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in pairs(slot0._rewarditems) do
		slot5.btn:RemoveClickListener()
		slot5.btncanget:RemoveClickListener()
		slot5.simagereward:UnLoadImage()
	end

	TaskDispatcher.cancelTask(slot0.onGetBonusCallback, slot0)
end

return slot0
