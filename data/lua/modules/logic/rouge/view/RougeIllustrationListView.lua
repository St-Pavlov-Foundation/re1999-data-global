module("modules.logic.rouge.view.RougeIllustrationListView", package.seeall)

local var_0_0 = class("RougeIllustrationListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageListBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_ListBG")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._sliderprogress = gohelper.findChildSlider(arg_1_0.viewGO, "#slider_progress")
	arg_1_0._goLeftTop = gohelper.findChild(arg_1_0.viewGO, "#go_LeftTop")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_LeftBottom/normal")
	arg_1_0._godlc = gohelper.findChild(arg_1_0.viewGO, "#go_LeftBottom/dlc")
	arg_1_0._btnnormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_LeftBottom/normal/btn_click")
	arg_1_0._gonormalunselect = gohelper.findChild(arg_1_0.viewGO, "#go_LeftBottom/normal/unselect")
	arg_1_0._gonormalselected = gohelper.findChild(arg_1_0.viewGO, "#go_LeftBottom/normal/selected")
	arg_1_0._btndlc = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_LeftBottom/dlc/btn_click")
	arg_1_0._godlcunselect = gohelper.findChild(arg_1_0.viewGO, "#go_LeftBottom/dlc/unselect")
	arg_1_0._godlcselected = gohelper.findChild(arg_1_0.viewGO, "#go_LeftBottom/dlc/selected")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/Content")
	arg_1_0._simagedlcbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#simage_dlcbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnormal:AddClickListener(arg_2_0._btnnormalOnClick, arg_2_0)
	arg_2_0._btndlc:AddClickListener(arg_2_0._btndlcOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnormal:RemoveClickListener()
	arg_3_0._btndlc:RemoveClickListener()
end

function var_0_0._btnnormalOnClick(arg_4_0)
	arg_4_0:refreshButtons(RougeEnum.IllustrationType.Normal)
	arg_4_0:focus2TargetPos(true, RougeEnum.IllustrationType.Normal)
end

function var_0_0._btndlcOnClick(arg_5_0)
	arg_5_0:refreshButtons(RougeEnum.IllustrationType.DLC)
	arg_5_0:focus2TargetPos(true, RougeEnum.IllustrationType.DLC)
end

function var_0_0.refreshButtons(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._gonormalselected, arg_6_1 == RougeEnum.IllustrationType.Normal)
	gohelper.setActive(arg_6_0._gonormalunselect, arg_6_1 ~= RougeEnum.IllustrationType.Normal)
	gohelper.setActive(arg_6_0._godlcselected, arg_6_1 == RougeEnum.IllustrationType.DLC)
	gohelper.setActive(arg_6_0._godlcunselect, arg_6_1 ~= RougeEnum.IllustrationType.DLC)
end

local var_0_1 = 0.01
local var_0_2 = 1
local var_0_3 = 0
local var_0_4 = 100

function var_0_0.focus2TargetPos(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_3

	if arg_7_2 == RougeEnum.IllustrationType.DLC then
		local var_7_1 = recthelper.getWidth(arg_7_0._goscrollcontent.transform)

		var_7_0 = RougeIllustrationListModel.instance:getSplitEmptySpaceStartPosX()

		local var_7_2 = recthelper.getWidth(arg_7_0._scrollview.transform)

		var_7_0 = Mathf.Clamp(var_7_0 / (var_7_1 - var_7_2), 0, 1)
	end

	arg_7_0:_moveScroll2TargetPos(arg_7_1, var_7_0)
end

function var_0_0._moveScroll2TargetPos(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:killTween()
	arg_8_0:endUIBlock()

	if arg_8_1 then
		local var_8_0 = true
		local var_8_1 = arg_8_0._scrollview.horizontalNormalizedPosition

		if math.abs(arg_8_2 - var_8_1) > var_0_1 then
			arg_8_0:startUIBlock()

			arg_8_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_8_1, arg_8_2, var_0_2, arg_8_0.tweenFrame, arg_8_0.tweenFinish, arg_8_0)
		end
	else
		arg_8_0._scrollview.horizontalNormalizedPosition = arg_8_2
	end
end

function var_0_0.tweenFrame(arg_9_0, arg_9_1)
	if not arg_9_0._scrollview then
		return
	end

	arg_9_0._scrollview.horizontalNormalizedPosition = arg_9_1
end

function var_0_0.tweenFinish(arg_10_0)
	arg_10_0._tweenId = nil

	arg_10_0:endUIBlock()
end

function var_0_0.killTween(arg_11_0)
	if arg_11_0._tweenId then
		ZProj.TweenHelper.KillById(arg_11_0._tweenId)

		arg_11_0._tweenId = nil
	end
end

function var_0_0.startUIBlock(arg_12_0)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeIllustrationTween")
end

function var_0_0.endUIBlock(arg_13_0)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("RougeIllustrationTween")
end

function var_0_0._editableInitView(arg_14_0)
	RougeIllustrationListModel.instance.startFrameCount = UnityEngine.Time.frameCount

	RougeIllustrationListModel.instance:initList()
end

function var_0_0.onOpen(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio4)
	arg_15_0:focus2TargetPos(false, RougeEnum.IllustrationType.Normal)
	arg_15_0:setSplitImagePos()
end

function var_0_0.setSplitImagePos(arg_16_0)
	local var_16_0 = RougeFavoriteConfig.instance:getDLCIllustationPageCount()
	local var_16_1 = var_16_0 and var_16_0 > 0

	gohelper.setActive(arg_16_0._simagedlcbg.gameObject, var_16_1)

	if not var_16_1 then
		return
	end

	local var_16_2 = RougeIllustrationListModel.instance:getSplitEmptySpaceStartPosX() + var_0_4

	recthelper.setAnchorX(arg_16_0._simagedlcbg.transform, var_16_2)
end

function var_0_0.onClose(arg_17_0)
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Illustration) > 0 then
		local var_17_0 = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(var_17_0, RougeEnum.FavoriteType.Illustration, 0)
	end

	arg_17_0:killTween()
	arg_17_0:endUIBlock()
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
