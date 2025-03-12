module("modules.logic.commonprop.view.CommonPropView", package.seeall)

slot0 = class("CommonPropView", BaseView)

if BootNativeUtil.isWindows() then
	module_views.CommonPropView.destroy = 1
end

function slot0.onInitView(slot0)
	slot0._bgClick = gohelper.getClick(slot0.viewGO)
	slot0._scrollitem = gohelper.findChild(slot0.viewGO, "#scroll_item")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_item/itemcontent")
	slot0._goeff = gohelper.findChild(slot0.viewGO, "#go_eff")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._bgClick:AddClickListener(slot0._onClickBG, slot0)
end

function slot0.removeEvents(slot0)
	slot0._bgClick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._contentGrid = slot0._gocontent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	slot0._titleAni = slot0.viewGO:GetComponent(typeof(UnityEngine.Animation))
	slot0._videoPlayer, slot0._displauUGUI = AvProMgr.instance:getVideoPlayer(gohelper.findChild(slot0.viewGO, "#go_video"))

	slot0._videoPlayer:Play(slot0._displauUGUI, langVideoUrl("commonprop"), true, nil, )
end

function slot0._onClickBG(slot0)
	if slot0._cantClose then
		return
	end

	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0._titleAni:Play()

	CommonPropListItem.hasOpen = false
	slot0._contentGrid.enabled = false

	slot0:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.CommonPropView, slot0._onClickBG, slot0)

	slot0._cantClose = true
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, , , , EaseType.Linear)

	TaskDispatcher.runDelay(slot0._setCanClose, slot0, 0.8)

	if CommonPropListModel.instance:isHadHighRareProp() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end
end

function slot0._setCanClose(slot0)
	slot0._cantClose = false
end

function slot0.onClose(slot0)
	if BootNativeUtil.isWindows() then
		slot0._videoPlayer:Stop()
	end

	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false

	if slot0._videoPlayer and not BootNativeUtil.isIOS() then
		slot0._videoPlayer:Stop()
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._setPropItems(slot0)
	CommonPropListModel.instance:setPropList(slot0.viewParam)

	if #CommonPropListModel.instance:getList() < 6 then
		transformhelper.setLocalPosXY(slot0._scrollitem.transform, 0, -185)

		slot0._contentGrid.enabled = true
	else
		slot0._contentGrid.enabled = false

		transformhelper.setLocalPosXY(slot0._scrollitem.transform, 0, -47)
	end
end

function slot0.onDestroyView(slot0)
	if BootNativeUtil.isWindows() then
		slot0._videoPlayer = nil
		slot0._displauUGUI = nil
	end

	if slot0._videoPlayer then
		if not BootNativeUtil.isIOS() and not BootNativeUtil.isWindows() then
			slot0._videoPlayer:Stop()
		end

		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	TaskDispatcher.cancelTask(slot0._setCanClose, slot0)
end

return slot0
