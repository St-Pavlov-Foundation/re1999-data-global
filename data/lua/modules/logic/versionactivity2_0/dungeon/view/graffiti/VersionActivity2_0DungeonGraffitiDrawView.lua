module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiDrawView", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonGraffitiDrawView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._gograffiti = gohelper.findChild(arg_1_0.viewGO, "#go_graffiti")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_graffiti/#simage_icon")
	arg_1_0._simagemaskicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_graffiti/#simage_maskicon")
	arg_1_0._imagemaskicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_graffiti/#simage_maskicon")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_start")
	arg_1_0._btnfinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_finish")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_info/image_TitleBG/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_info/Scroll View/Viewport/#txt_desc")
	arg_1_0._godrawcan = gohelper.findChild(arg_1_0.viewGO, "#go_drawcan")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_Tips")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._graffitiAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0._gograffiti)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnfinish:AddClickListener(arg_2_0._btnfinishOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnfinish:RemoveClickListener()
end

function var_0_0._btnstartOnClick(arg_4_0)
	arg_4_0._graffitiAnimatorPlayer:Play(UIAnimationName.Click, arg_4_0.hideBlock, arg_4_0)
	gohelper.setActive(arg_4_0._btnstart.gameObject, false)
	gohelper.setActive(arg_4_0._gotips.gameObject, true)
	TaskDispatcher.runDelay(arg_4_0.addComp, arg_4_0, 0.01)
	UIBlockMgr.instance:startBlock("enlargePictureAnim")
	arg_4_0.viewContainer:setIsBeginDrawState(true)
	gohelper.setActive(arg_4_0._gotopleft, false)
end

function var_0_0.hideBlock(arg_5_0)
	UIBlockMgr.instance:endBlock("enlargePictureAnim")
end

function var_0_0._btnfinishOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._godrawcan, false)
	gohelper.setActive(arg_7_0._gotips, false)

	arg_7_0.rectTrViewGo = arg_7_0.viewGO:GetComponent(gohelper.Type_RectTransform)
end

function var_0_0.setNativeSize(arg_8_0)
	ZProj.UGUIHelper.SetImageSize(arg_8_0._simageicon.gameObject)
end

function var_0_0.setMaskNativeSize(arg_9_0)
	ZProj.UGUIHelper.SetImageSize(arg_9_0._simagemaskicon.gameObject)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:initData()
	arg_10_0:refreshUI()
end

function var_0_0.initData(arg_11_0)
	arg_11_0.state = arg_11_0.viewParam.graffitiMO.state
	arg_11_0.graffitiId = arg_11_0.viewParam.graffitiMO.id
	arg_11_0.config = arg_11_0.viewParam.graffitiMO.config
	arg_11_0.normalMaterial = arg_11_0.viewParam.normalMaterial
	arg_11_0.isFinish = arg_11_0.state == Activity161Enum.graffitiState.IsFinished

	local var_11_0 = string.format("%s_manual", arg_11_0.config.picture)
	local var_11_1 = string.format("%s_manual", arg_11_0.config.picture)

	arg_11_0._simageicon:LoadImage(ResUrl.getGraffitiIcon(var_11_0), arg_11_0.setNativeSize, arg_11_0)
	arg_11_0._simagemaskicon:LoadImage(ResUrl.getGraffitiIcon(var_11_1), arg_11_0.setMaskNativeSize, arg_11_0)

	arg_11_0._imagemaskicon.material = arg_11_0.normalMaterial
	arg_11_0.uiCamera = CameraMgr.instance:getUICamera()

	gohelper.setActive(arg_11_0._gotopleft, true)
end

function var_0_0.addComp(arg_12_0)
	arg_12_0.erasePicture = ZProj.ErasePicture.AddComp(arg_12_0._gograffiti)

	arg_12_0.erasePicture:InitData(arg_12_0.config.brushSize, arg_12_0.config.finishRate, arg_12_0._imagemaskicon, arg_12_0.uiCamera)
	arg_12_0.erasePicture:setCallBack(arg_12_0.startDraw, arg_12_0, arg_12_0.showRate, arg_12_0, arg_12_0.endDraw, arg_12_0, arg_12_0.finishDraw, arg_12_0)
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0._txttitle.text = arg_13_0.config.finishTitle
	arg_13_0._txtdesc.text = arg_13_0.config.finishDesc

	gohelper.setActive(arg_13_0._goinfo, arg_13_0.isFinish)
	gohelper.setActive(arg_13_0._btnstart, not arg_13_0.isFinish)
	gohelper.setActive(arg_13_0._btnfinish.gameObject, arg_13_0.isFinish)
	gohelper.setActive(arg_13_0._simagemaskicon.gameObject, not arg_13_0.isFinish)
end

function var_0_0.startDraw(arg_14_0)
	if arg_14_0.isFinish then
		return
	end

	gohelper.setActive(arg_14_0._godrawcan, true)
	arg_14_0:setDrawCanPos()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_spray_loop)
end

function var_0_0.showRate(arg_15_0)
	if arg_15_0.isFinish then
		return
	end

	gohelper.setActive(arg_15_0._godrawcan, true)
	arg_15_0:setDrawCanPos()
end

function var_0_0.endDraw(arg_16_0)
	gohelper.setActive(arg_16_0._godrawcan, false)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_spray_loop)
end

function var_0_0.setDrawCanPos(arg_17_0)
	local var_17_0, var_17_1 = recthelper.screenPosToAnchorPos2(GamepadController.instance:getMousePosition(), arg_17_0.rectTrViewGo)

	recthelper.setAnchor(arg_17_0._godrawcan.transform, var_17_0, var_17_1)
end

function var_0_0.finishDraw(arg_18_0)
	if arg_18_0.isFinish then
		return
	end

	arg_18_0.isFinish = true

	gohelper.setActive(arg_18_0._godrawcan, false)
	gohelper.setActive(arg_18_0._gotips.gameObject, false)
	arg_18_0:refreshUI()
	DungeonRpc.instance:sendMapElementRequest(arg_18_0.config.elementId)
	Activity161Model.instance:setGraffitiState(arg_18_0.config.elementId, Activity161Enum.graffitiState.IsFinished)
	arg_18_0.viewContainer:setIsBeginDrawState(false)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_spray_loop)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_spray_finish)
	arg_18_0._graffitiAnimatorPlayer:Play("finish")
	Activity161Controller.instance:dispatchEvent(Activity161Event.FinishDrawGraffiti)
end

function var_0_0.onClose(arg_19_0)
	arg_19_0._simageicon:UnLoadImage()
	arg_19_0._simagemaskicon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_19_0.addComp, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.hideBlock, arg_19_0)
	UIBlockMgr.instance:endBlock("enlargePictureAnim")
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
