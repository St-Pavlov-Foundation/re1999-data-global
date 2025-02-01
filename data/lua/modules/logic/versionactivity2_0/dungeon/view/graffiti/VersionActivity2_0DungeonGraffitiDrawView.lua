module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiDrawView", package.seeall)

slot0 = class("VersionActivity2_0DungeonGraffitiDrawView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._gograffiti = gohelper.findChild(slot0.viewGO, "#go_graffiti")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_graffiti/#simage_icon")
	slot0._simagemaskicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_graffiti/#simage_maskicon")
	slot0._imagemaskicon = gohelper.findChildImage(slot0.viewGO, "#go_graffiti/#simage_maskicon")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_start")
	slot0._btnfinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_finish")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_info/image_TitleBG/#txt_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_info/Scroll View/Viewport/#txt_desc")
	slot0._godrawcan = gohelper.findChild(slot0.viewGO, "#go_drawcan")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_Tips")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._graffitiAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gograffiti)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnfinish:AddClickListener(slot0._btnfinishOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btnfinish:RemoveClickListener()
end

function slot0._btnstartOnClick(slot0)
	slot0._graffitiAnimatorPlayer:Play(UIAnimationName.Click, slot0.hideBlock, slot0)
	gohelper.setActive(slot0._btnstart.gameObject, false)
	gohelper.setActive(slot0._gotips.gameObject, true)
	TaskDispatcher.runDelay(slot0.addComp, slot0, 0.01)
	UIBlockMgr.instance:startBlock("enlargePictureAnim")
	slot0.viewContainer:setIsBeginDrawState(true)
	gohelper.setActive(slot0._gotopleft, false)
end

function slot0.hideBlock(slot0)
	UIBlockMgr.instance:endBlock("enlargePictureAnim")
end

function slot0._btnfinishOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._godrawcan, false)
	gohelper.setActive(slot0._gotips, false)

	slot0.rectTrViewGo = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)
end

function slot0.setNativeSize(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simageicon.gameObject)
end

function slot0.setMaskNativeSize(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simagemaskicon.gameObject)
end

function slot0.onOpen(slot0)
	slot0:initData()
	slot0:refreshUI()
end

function slot0.initData(slot0)
	slot0.state = slot0.viewParam.graffitiMO.state
	slot0.graffitiId = slot0.viewParam.graffitiMO.id
	slot0.config = slot0.viewParam.graffitiMO.config
	slot0.normalMaterial = slot0.viewParam.normalMaterial
	slot0.isFinish = slot0.state == Activity161Enum.graffitiState.IsFinished

	slot0._simageicon:LoadImage(ResUrl.getGraffitiIcon(string.format("%s_manual", slot0.config.picture)), slot0.setNativeSize, slot0)
	slot0._simagemaskicon:LoadImage(ResUrl.getGraffitiIcon(string.format("%s_manual", slot0.config.picture)), slot0.setMaskNativeSize, slot0)

	slot0._imagemaskicon.material = slot0.normalMaterial
	slot0.uiCamera = CameraMgr.instance:getUICamera()

	gohelper.setActive(slot0._gotopleft, true)
end

function slot0.addComp(slot0)
	slot0.erasePicture = ZProj.ErasePicture.AddComp(slot0._gograffiti)

	slot0.erasePicture:InitData(slot0.config.brushSize, slot0.config.finishRate, slot0._imagemaskicon, slot0.uiCamera)
	slot0.erasePicture:setCallBack(slot0.startDraw, slot0, slot0.showRate, slot0, slot0.endDraw, slot0, slot0.finishDraw, slot0)
end

function slot0.refreshUI(slot0)
	slot0._txttitle.text = slot0.config.finishTitle
	slot0._txtdesc.text = slot0.config.finishDesc

	gohelper.setActive(slot0._goinfo, slot0.isFinish)
	gohelper.setActive(slot0._btnstart, not slot0.isFinish)
	gohelper.setActive(slot0._btnfinish.gameObject, slot0.isFinish)
	gohelper.setActive(slot0._simagemaskicon.gameObject, not slot0.isFinish)
end

function slot0.startDraw(slot0)
	if slot0.isFinish then
		return
	end

	gohelper.setActive(slot0._godrawcan, true)
	slot0:setDrawCanPos()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_spray_loop)
end

function slot0.showRate(slot0)
	if slot0.isFinish then
		return
	end

	gohelper.setActive(slot0._godrawcan, true)
	slot0:setDrawCanPos()
end

function slot0.endDraw(slot0)
	gohelper.setActive(slot0._godrawcan, false)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_spray_loop)
end

function slot0.setDrawCanPos(slot0)
	slot1, slot2 = recthelper.screenPosToAnchorPos2(GamepadController.instance:getMousePosition(), slot0.rectTrViewGo)

	recthelper.setAnchor(slot0._godrawcan.transform, slot1, slot2)
end

function slot0.finishDraw(slot0)
	if slot0.isFinish then
		return
	end

	slot0.isFinish = true

	gohelper.setActive(slot0._godrawcan, false)
	gohelper.setActive(slot0._gotips.gameObject, false)
	slot0:refreshUI()
	DungeonRpc.instance:sendMapElementRequest(slot0.config.elementId)
	Activity161Model.instance:setGraffitiState(slot0.config.elementId, Activity161Enum.graffitiState.IsFinished)
	slot0.viewContainer:setIsBeginDrawState(false)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_spray_loop)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_spray_finish)
	slot0._graffitiAnimatorPlayer:Play("finish")
	Activity161Controller.instance:dispatchEvent(Activity161Event.FinishDrawGraffiti)
end

function slot0.onClose(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._simagemaskicon:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.addComp, slot0)
	TaskDispatcher.cancelTask(slot0.hideBlock, slot0)
	UIBlockMgr.instance:endBlock("enlargePictureAnim")
end

function slot0.onDestroyView(slot0)
end

return slot0
