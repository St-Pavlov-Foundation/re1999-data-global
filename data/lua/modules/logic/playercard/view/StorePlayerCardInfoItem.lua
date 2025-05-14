module("modules.logic.playercard.view.StorePlayerCardInfoItem", package.seeall)

local var_0_0 = class("StorePlayerCardInfoItem", SocialFriendItem)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0._playericon:setEnableClick(false)
end

function var_0_0.onShowDecorateStoreDefault(arg_2_0)
	arg_2_0:playAnim("open", 1)

	if arg_2_0._goskinEffect then
		if not arg_2_0._skinEffectAnim then
			arg_2_0._skinEffectAnim = arg_2_0._goskinEffect:GetComponent(typeof(UnityEngine.Animator))
		end

		arg_2_0._skinEffectAnim:Play("open", 0, 1)
	end
end

function var_0_0.playAnim(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.viewAnim then
		arg_3_0.viewAnim:Play(arg_3_1, 0, arg_3_2)
	end
end

return var_0_0
