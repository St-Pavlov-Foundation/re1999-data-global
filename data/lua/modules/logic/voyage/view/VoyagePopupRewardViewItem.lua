module("modules.logic.voyage.view.VoyagePopupRewardViewItem", package.seeall)

local var_0_0 = class("VoyagePopupRewardViewItem", ActivityGiftForTheVoyageItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagenum = gohelper.findChildImage(arg_1_0.viewGO, "#image_num")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "#go_num")
	arg_1_0._goimgall = gohelper.findChild(arg_1_0.viewGO, "#go_imgall")
	arg_1_0._txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_taskdesc")
	arg_1_0._scrollRewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Rewards")
	arg_1_0._goRewards = gohelper.findChild(arg_1_0.viewGO, "#scroll_Rewards/Viewport/#go_Rewards")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._gonumTrans = arg_4_0._gonum.transform
	arg_4_0._bg = gohelper.findChild(arg_4_0.viewGO, "bg")
end

local var_0_1 = 1

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._gonumTrans.childCount
	local var_5_1 = math.max(arg_5_0._index, var_5_0)

	for iter_5_0 = 1 + var_0_1, var_5_1 do
		if var_5_0 <= iter_5_0 - 1 then
			break
		end

		local var_5_2 = arg_5_0._gonumTrans:GetChild(iter_5_0 - 1)

		GameUtil.setActive01(var_5_2, arg_5_0._index == iter_5_0 - var_0_1)
	end

	ZProj.UGUIHelper.SetColorAlpha(arg_5_0._bg:GetComponent(gohelper.Type_Image), arg_5_1.id > 0 and 0.7 or 1)
	var_0_0.super.onUpdateMO(arg_5_0, arg_5_1)
end

function var_0_0.onRefresh(arg_6_0)
	local var_6_0 = arg_6_0._mo

	arg_6_0._txttaskdesc.text = var_6_0.desc

	gohelper.setActive(arg_6_0._goimgall, var_6_0.id == -1)
	arg_6_0:_refreshRewardList(arg_6_0._goRewards)

	arg_6_0._scrollRewards.horizontalNormalizedPosition = 0
end

return var_0_0
