module("modules.logic.playercard.view.StorePlayerCardInfoItem", package.seeall)

slot0 = class("StorePlayerCardInfoItem", SocialFriendItem)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0.viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0._playericon:setEnableClick(false)
end

function slot0.onShowDecorateStoreDefault(slot0)
	slot0:playAnim("open", 1)

	if slot0._goskinEffect then
		if not slot0._skinEffectAnim then
			slot0._skinEffectAnim = slot0._goskinEffect:GetComponent(typeof(UnityEngine.Animator))
		end

		slot0._skinEffectAnim:Play("open", 0, 1)
	end
end

function slot0.playAnim(slot0, slot1, slot2)
	if slot0.viewAnim then
		slot0.viewAnim:Play(slot1, 0, slot2)
	end
end

return slot0
