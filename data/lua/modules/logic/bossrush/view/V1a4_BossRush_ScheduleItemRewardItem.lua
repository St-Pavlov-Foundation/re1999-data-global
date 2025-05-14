module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleItemRewardItem", package.seeall)

local var_0_0 = class("V1a4_BossRush_ScheduleItemRewardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._imageQualityBg = gohelper.findChildImage(arg_1_1, "image_QualityBg")
	arg_1_0._simageReward = gohelper.findChildSingleImage(arg_1_1, "simage_Reward")
	arg_1_0._imageQualityFrame = gohelper.findChildImage(arg_1_1, "image_QualityFrame")
	arg_1_0._goHasGet = gohelper.findChild(arg_1_1, "go_HasGet")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_1, "txt_Desc")
	arg_1_0._click = gohelper.getClick(arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._anim = arg_1_1:GetComponent(gohelper.Type_Animator)
	arg_1_0._goHasGetAnim = arg_1_0._goHasGet:GetComponent(gohelper.Type_Animator)

	arg_1_0._click:AddClickListener(arg_1_0._onClick, arg_1_0)

	arg_1_0._isActive = false

	gohelper.setActive(arg_1_1, false)
end

function var_0_0.onDestroy(arg_2_0)
	arg_2_0._click:RemoveClickListener()

	if arg_2_0._simageReward then
		arg_2_0._simageReward:UnLoadImage()
	end

	arg_2_0._simageReward = nil
end

function var_0_0.onDestroyView(arg_3_0)
	arg_3_0:onDestroy()
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0._itemCO = arg_4_1

	local var_4_0 = arg_4_1[1]
	local var_4_1 = arg_4_1[2]
	local var_4_2 = arg_4_1[3]
	local var_4_3, var_4_4 = ItemModel.instance:getItemConfigAndIcon(var_4_0, var_4_1)
	local var_4_5 = var_4_3.rare

	UISpriteSetMgr.instance:setV1a4BossRushSprite(arg_4_0._imageQualityBg, BossRushConfig.instance:getQualityBgSpriteName(var_4_5))
	UISpriteSetMgr.instance:setV1a4BossRushSprite(arg_4_0._imageQualityFrame, BossRushConfig.instance:getQualityFrameSpriteName(var_4_5))
	arg_4_0._simageReward:LoadImage(var_4_4)

	arg_4_0._txtDesc.text = luaLang("multiple") .. var_4_2
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	if arg_5_0._isActive == arg_5_1 then
		return
	end

	arg_5_0._isActive = arg_5_1

	gohelper.setActive(arg_5_0.go, arg_5_1)
end

function var_0_0._onClick(arg_6_0)
	local var_6_0 = arg_6_0._itemCO

	if not var_6_0 then
		return
	end

	MaterialTipController.instance:showMaterialInfo(var_6_0[1], var_6_0[2])
end

function var_0_0.playAnim_HasGet(arg_7_0, arg_7_1, ...)
	arg_7_0._goHasGetAnim:Play(arg_7_1, ...)
end

function var_0_0.playAnim(arg_8_0, arg_8_1, ...)
	arg_8_0._anim:Play(arg_8_1, ...)
end

return var_0_0
