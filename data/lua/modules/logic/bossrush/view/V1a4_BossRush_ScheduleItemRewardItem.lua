module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleItemRewardItem", package.seeall)

slot0 = class("V1a4_BossRush_ScheduleItemRewardItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._imageQualityBg = gohelper.findChildImage(slot1, "image_QualityBg")
	slot0._simageReward = gohelper.findChildSingleImage(slot1, "simage_Reward")
	slot0._imageQualityFrame = gohelper.findChildImage(slot1, "image_QualityFrame")
	slot0._goHasGet = gohelper.findChild(slot1, "go_HasGet")
	slot0._txtDesc = gohelper.findChildText(slot1, "txt_Desc")
	slot0._click = gohelper.getClick(slot1)
	slot0.go = slot1
	slot0._anim = slot1:GetComponent(gohelper.Type_Animator)
	slot0._goHasGetAnim = slot0._goHasGet:GetComponent(gohelper.Type_Animator)

	slot0._click:AddClickListener(slot0._onClick, slot0)

	slot0._isActive = false

	gohelper.setActive(slot1, false)
end

function slot0.onDestroy(slot0)
	slot0._click:RemoveClickListener()

	if slot0._simageReward then
		slot0._simageReward:UnLoadImage()
	end

	slot0._simageReward = nil
end

function slot0.onDestroyView(slot0)
	slot0:onDestroy()
end

function slot0.setData(slot0, slot1)
	slot0._itemCO = slot1
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot1[1], slot1[2])
	slot7 = slot5.rare

	UISpriteSetMgr.instance:setV1a4BossRushSprite(slot0._imageQualityBg, BossRushConfig.instance:getQualityBgSpriteName(slot7))
	UISpriteSetMgr.instance:setV1a4BossRushSprite(slot0._imageQualityFrame, BossRushConfig.instance:getQualityFrameSpriteName(slot7))
	slot0._simageReward:LoadImage(slot6)

	slot0._txtDesc.text = luaLang("multiple") .. slot1[3]
end

function slot0.setActive(slot0, slot1)
	if slot0._isActive == slot1 then
		return
	end

	slot0._isActive = slot1

	gohelper.setActive(slot0.go, slot1)
end

function slot0._onClick(slot0)
	if not slot0._itemCO then
		return
	end

	MaterialTipController.instance:showMaterialInfo(slot1[1], slot1[2])
end

function slot0.playAnim_HasGet(slot0, slot1, ...)
	slot0._goHasGetAnim:Play(slot1, ...)
end

function slot0.playAnim(slot0, slot1, ...)
	slot0._anim:Play(slot1, ...)
end

return slot0
