module("modules.logic.battlepass.view.BpPropView", package.seeall)

local var_0_0 = class("BpPropView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._bgClick = gohelper.getClick(arg_1_0.viewGO)
	arg_1_0._scrollitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_item")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_item/itemcontent")
	arg_1_0._goeff = gohelper.findChild(arg_1_0.viewGO, "#go_eff")
	arg_1_0._govideo = gohelper.findChild(arg_1_0.viewGO, "#go_video")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._bgClick:AddClickListener(arg_2_0._onClickBG, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._bgClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._contentGrid = arg_4_0._gocontent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	arg_4_0._titleAni = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animation))
	arg_4_0._videoPlayer, arg_4_0._displauUGUI = AvProMgr.instance:getVideoPlayer(arg_4_0._govideo)

	arg_4_0._videoPlayer:Play(arg_4_0._displauUGUI, "videos/commonprop.mp4", true, nil, nil)
end

function var_0_0._onClickBG(arg_5_0)
	if arg_5_0._cantClose then
		return
	end

	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._titleAni:Play()

	CommonPropListItem.hasOpen = false
	arg_6_0._contentGrid.enabled = false

	arg_6_0:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.BpPropView, arg_6_0._onClickBG, arg_6_0)

	arg_6_0._cantClose = true
	arg_6_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, arg_6_0._tweenFinish, arg_6_0, nil, EaseType.Linear)

	if CommonPropListModel.instance:isHadHighRareProp() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end
end

function var_0_0._tweenFinish(arg_7_0)
	arg_7_0._cantClose = false
end

function var_0_0.onClose(arg_8_0)
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._setPropItems(arg_10_0)
	CommonPropListModel.instance:setPropList(arg_10_0.viewParam)

	if #CommonPropListModel.instance:getList() < 6 then
		transformhelper.setLocalPosXY(arg_10_0._scrollitem.transform, 0, -185)

		arg_10_0._contentGrid.enabled = true
	else
		arg_10_0._contentGrid.enabled = false

		transformhelper.setLocalPosXY(arg_10_0._scrollitem.transform, 0, -47)
	end
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0._videoPlayer then
		arg_11_0._videoPlayer:Stop()
		arg_11_0._videoPlayer:Clear()

		arg_11_0._videoPlayer = nil
	end

	if arg_11_0._tweenId then
		ZProj.TweenHelper.KillById(arg_11_0._tweenId)
	end
end

return var_0_0
