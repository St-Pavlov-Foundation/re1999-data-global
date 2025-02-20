module("modules.logic.character.view.CharacterView", package.seeall)

slot0 = class("CharacterView", BaseView)
slot1 = 5

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "anim/bgcanvas/bg/#simage_bg")
	slot0._simageplayerbg = gohelper.findChildSingleImage(slot0.viewGO, "anim/bgcanvas/bg/#simage_playerbg")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "anim/#go_herocontainer/dynamiccontainer/#go_spine")
	slot0._simagestatic = gohelper.findChildSingleImage(slot0.viewGO, "anim/#go_herocontainer/staticcontainer/#simage_static")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/go_btns/#btn_close")
	slot0._btnhome = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/go_btns/#btn_home")
	slot0._btndata = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/go_btns/#btn_data")
	slot0._godatareddot = gohelper.findChild(slot0.viewGO, "anim/go_btns/#btn_data/#go_datareddot")
	slot0._btnskin = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/go_btns/#btn_skin")
	slot0._btnfavor = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/go_btns/#btn_favor")
	slot0._imagefavor = gohelper.findChildImage(slot0.viewGO, "anim/go_btns/#btn_favor")
	slot0._btnhelp = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/go_btns/#btn_help")
	slot0._gorare = gohelper.findChild(slot0.viewGO, "anim/info/#go_rare")
	slot0._imagecareericon = gohelper.findChildImage(slot0.viewGO, "anim/info/#image_careericon")
	slot0._imagedmgtype = gohelper.findChildImage(slot0.viewGO, "anim/info/#image_dmgtype")
	slot0._txtnamecn = gohelper.findChildText(slot0.viewGO, "anim/info/#txt_namecn")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "anim/info/#txt_namecn/#txt_nameen")
	slot0._txttrust = gohelper.findChildText(slot0.viewGO, "anim/info/trust/#txt_trust")
	slot0._slidertrust = gohelper.findChildSlider(slot0.viewGO, "anim/info/trust/#slider_trust")
	slot0._gocareer = gohelper.findChild(slot0.viewGO, "anim/#go_career")
	slot0._btnattribute = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/attribute/#btn_attribute")
	slot0._goattributenode = gohelper.findChild(slot0.viewGO, "anim/attribute")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "anim/attribute/#go_attribute")
	slot0._goattributetipsnode = gohelper.findChild(slot0.viewGO, "anim/#go_attributetips")
	slot0._animatorattributetipsnode = slot0._goattributetipsnode:GetComponent(typeof(UnityEngine.Animator))
	slot0._goattributetips = gohelper.findChild(slot0.viewGO, "anim/#go_attributetips/#go_attribute")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "anim/level/lvtxt/#txt_level")
	slot0._txtlevelmax = gohelper.findChildText(slot0.viewGO, "anim/level/lvtxt/#txt_level/#txt_levelmax")
	slot0._btnlevel = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/level/#btn_level")
	slot0._gorankeyes = gohelper.findChild(slot0.viewGO, "anim/rank/#go_rankeyes")
	slot0._goranklights = gohelper.findChild(slot0.viewGO, "anim/rank/#go_ranklights")
	slot0._btnrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/rank/#btn_rank")
	slot0._gorankreddot = gohelper.findChild(slot0.viewGO, "anim/rank/#go_rankreddot")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "anim/layout/#go_skill")
	slot0._btnpassiveskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/passiveskill/#btn_passiveskill")
	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "anim/passiveskill/bg/passiveskillimage/#txt_passivename")
	slot0._gopassiveskills = gohelper.findChild(slot0.viewGO, "anim/passiveskill/#go_passiveskills")
	slot0._btnexskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/layout/rightbottom/exskill/#btn_exskill")
	slot0._goexskills = gohelper.findChild(slot0.viewGO, "anim/layout/rightbottom/exskill/#go_exskills")
	slot0._goexskillreddot = gohelper.findChild(slot0.viewGO, "anim/layout/rightbottom/exskill/#go_exskillreddot")
	slot0._gotalent = gohelper.findChild(slot0.viewGO, "anim/layout/rightbottom/#go_talent")
	slot0._txttalentcn = gohelper.findChildText(slot0.viewGO, "anim/layout/rightbottom/#go_talent/talentcn")
	slot0._txttalenten = gohelper.findChildText(slot0.viewGO, "anim/layout/rightbottom/#go_talent/talentcn/talenten")
	slot0._btntalent = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/layout/rightbottom/#go_talent/#btn_talent")
	slot0._gotalents = gohelper.findChild(slot0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talents")
	slot0._gotalentstyle = gohelper.findChild(slot0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentstyle")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentstyle/#image_icon")
	slot0._txttalentvalue = gohelper.findChildText(slot0.viewGO, "anim/layout/rightbottom/#go_talent/#txt_talentvalue")
	slot0._gotalentlock = gohelper.findChild(slot0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentlock")
	slot0._gotalentreddot = gohelper.findChild(slot0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentreddot")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "anim/bottom/#go_contentbg")
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "anim/bottom/#txt_ana_cn")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "anim/bottom/#txt_ana_en")
	slot0._godynamiccontainer = gohelper.findChild(slot0.viewGO, "anim/#go_herocontainer/dynamiccontainer")
	slot0._gostaticcontainer = gohelper.findChild(slot0.viewGO, "anim/#go_herocontainer/staticcontainer")
	slot0._goherocontainer = gohelper.findChild(slot0.viewGO, "anim/#go_herocontainer")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "anim/bottom/#simage_signature")
	slot0._golevelimage = gohelper.findChild(slot0.viewGO, "anim/level/levelimage")
	slot0._golevelicon = gohelper.findChild(slot0.viewGO, "anim/level/addicon")
	slot0._golevelimagetrial = gohelper.findChild(slot0.viewGO, "anim/level/#go_levelimagetrial")
	slot0._gorankimage = gohelper.findChild(slot0.viewGO, "anim/rank/rankimage")
	slot0._gorankicon = gohelper.findChild(slot0.viewGO, "anim/rank/addicon")
	slot0._gorankimagetrial = gohelper.findChild(slot0.viewGO, "anim/rank/#go_rankimagetrial")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnhome:AddClickListener(slot0._btnhomeOnClick, slot0)
	slot0._btndata:AddClickListener(slot0._btndataOnClick, slot0)
	slot0._btnskin:AddClickListener(slot0._btnskinOnClick, slot0)
	slot0._btnfavor:AddClickListener(slot0._btnfavorOnClick, slot0)
	slot0._btnhelp:AddClickListener(slot0._btnhelpOnClick, slot0)
	slot0._btnattribute:AddClickListener(slot0._btnattributeOnClick, slot0)
	slot0._btnlevel:AddClickListener(slot0._btnlevelOnClick, slot0)
	slot0._btnrank:AddClickListener(slot0._btnrankOnClick, slot0)
	slot0._btnpassiveskill:AddClickListener(slot0._btnpassiveskillOnClick, slot0)
	slot0._btnexskill:AddClickListener(slot0._btnexskillOnClick, slot0)
	slot0._btntalent:AddClickListener(slot0._btntalentOnClick, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, slot0._onApplicationPause, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, slot0._refreshAttributeTips, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.onTalentStyleRead, slot0._refreshTalentRed, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, slot0._onRefreshStyleIcon, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, slot0._onRefreshStyleIcon, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnhome:RemoveClickListener()
	slot0._btndata:RemoveClickListener()
	slot0._btnskin:RemoveClickListener()
	slot0._btnfavor:RemoveClickListener()
	slot0._btnhelp:RemoveClickListener()
	slot0._btnattribute:RemoveClickListener()
	slot0._btnlevel:RemoveClickListener()
	slot0._btnrank:RemoveClickListener()
	slot0._btnpassiveskill:RemoveClickListener()
	slot0._btnexskill:RemoveClickListener()
	slot0._btntalent:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.onApplicationPause, slot0._onApplicationPause, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, slot0._refreshAttributeTips, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.onTalentStyleRead, slot0._refreshTalentRed, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, slot0._onRefreshStyleIcon, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, slot0._onRefreshStyleIcon, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, slot0._markFavorSuccess, slot0)
end

slot0.HpAttrId = 101
slot0.AttackAttrId = 102
slot0.DefenseAttrId = 103
slot0.MdefenseAttrId = 104
slot0.TechnicAttrId = 105
slot0.RankIconOffset = 51.38
slot0.AttrIconColor = GameUtil.parseColor("#9b795e")
slot0.AttrIdList = {
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Mdefense,
	CharacterEnum.AttrId.Attack
}

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnlevel.gameObject, AudioEnum.UI.Play_Ui_Level_Unfold)
	gohelper.addUIClickAudio(slot0._btndata.gameObject, AudioEnum.UI.UI_role_introduce_open)
	gohelper.addUIClickAudio(slot0._btnskin.gameObject, AudioEnum.UI.UI_role_skin_open)
	gohelper.addUIClickAudio(slot0._btnhelp.gameObject, AudioEnum.UI.UI_help_open)
	gohelper.addUIClickAudio(slot0._btnclose.gameObject, AudioEnum.UI.UI_Rolesclose)
	gohelper.addUIClickAudio(slot0._btnhome.gameObject, AudioEnum.UI.UI_Rolesclose)
	gohelper.addUIClickAudio(slot0._btnattribute.gameObject, AudioEnum.UI.Play_ui_role_description)
	gohelper.addUIClickAudio(slot0._btntalent.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(slot0._btnrank.gameObject, AudioEnum.UI.play_ui_role_insight_open)
	gohelper.setActive(slot0._btnskin.gameObject, CharacterEnum.SkinOpen)
	gohelper.setActive(slot0._btnhelp.gameObject, HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character))
	slot0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/juese_bj"))
	slot0._simageplayerbg:LoadImage(ResUrl.getCharacterIcon("guangyun"))

	slot5 = true
	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, slot5)
	slot0._rareStars = slot0:getUserDataTb_()

	for slot5 = 1, 6 do
		slot0._rareStars[slot5] = gohelper.findChild(slot0._gorare, "rare" .. slot5)
	end

	slot0._careerlabels = slot0:getUserDataTb_()

	for slot5 = 1, 3 do
		slot0._careerlabels[slot5] = gohelper.findChildText(slot0._gocareer, "careerlabel" .. slot5)
	end

	slot0._attributevalues = {}
	slot0._levelUpAttributeValues = {}

	for slot5 = 1, uv0 do
		slot6 = slot0:getUserDataTb_()
		slot6.value = gohelper.findChildText(slot0._goattribute, "attribute" .. tostring(slot5) .. "/txt_attribute")
		slot6.name = gohelper.findChildText(slot0._goattribute, "attribute" .. tostring(slot5) .. "/name")
		slot6.icon = gohelper.findChildImage(slot0._goattribute, "attribute" .. tostring(slot5) .. "/icon")
		slot6.rate = gohelper.findChildImage(slot0._goattribute, "attribute" .. tostring(slot5) .. "/rate")

		gohelper.setActive(slot6.rate.gameObject, false)

		slot0._attributevalues[slot5] = slot6
		slot7 = slot0:getUserDataTb_()
		slot8 = "attribute" .. tostring(slot5)
		slot7.value = gohelper.findChildText(slot0._goattributetips, slot8 .. "/txt_attribute")
		slot7.newValue = gohelper.findChildText(slot0._goattributetips, slot8 .. "/txt_attribute/txt_attribute2")
		slot7.newValueArrow = gohelper.findChildImage(slot0._goattributetips, slot8 .. "/txt_attribute/image_Arrow")
		slot7.name = gohelper.findChildText(slot0._goattributetips, slot8 .. "/name")
		slot7.icon = gohelper.findChildImage(slot0._goattributetips, slot8 .. "/icon")
		slot0._levelUpAttributeValues[slot5] = slot7
	end

	slot0._ranklights = {}

	for slot5 = 1, 3 do
		slot6 = slot0:getUserDataTb_()
		slot10 = "light" .. slot5
		slot6.go = gohelper.findChild(slot0._goranklights, slot10)
		slot6.lights = slot0:getUserDataTb_()

		for slot10 = 1, slot5 do
			table.insert(slot6.lights, gohelper.findChild(slot6.go, "star" .. slot10))
		end

		slot0._ranklights[slot5] = slot6
	end

	slot5 = CharacterSkillContainer
	slot0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goskill, slot5)
	slot0._passiveskillitems = {}

	for slot5 = 1, 3 do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.findChild(slot0._gopassiveskills, "passiveskill" .. tostring(slot5))
		slot6.on = gohelper.findChild(slot6.go, "on")
		slot6.off = gohelper.findChild(slot6.go, "off")
		slot0._passiveskillitems[slot5] = slot6
	end

	slot0._exskills = slot0:getUserDataTb_()

	for slot5 = 1, 5 do
		slot0._exskills[slot5] = gohelper.findChild(slot0._goexskills, "exskill" .. tostring(slot5))
	end

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._goherocontainer)
	slot0._signatureDrag = SLFramework.UGUI.UIDragListener.Get(slot0._simagesignature.gameObject)
	slot0._trustclick = SLFramework.UGUI.UIClickListener.Get(slot0._txttrust.gameObject)
	slot0._careerclick = SLFramework.UGUI.UIClickListener.Get(slot0._imagecareericon.gameObject)
	slot0._signatureClick = SLFramework.UGUI.UIClickListener.Get(slot0._simagesignature.gameObject)
	slot0._enableSwitchDrawing = false
	slot0._gopifu = gohelper.findChild(slot0.viewGO, "anim/bottom/#pifu")

	gohelper.setActive(slot0._gopifu, slot0._enableSwitchDrawing)
	slot0:_addListener()

	slot0._originSpineRootPosX = recthelper.getAnchorX(slot0._goherocontainer.transform)
	slot0._animator = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._herocontainerCanvasGroup = slot0._goherocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._hasMoveIcon = false

	gohelper.setActive(slot0._goattributenode, true)
	slot0._animatorattributetipsnode:Play("close", 0, 1)

	slot0._talentRedType1 = gohelper.findChild(slot0._gotalentreddot, "type1")
	slot0._talentRedNew = gohelper.findChild(slot0._gotalentreddot, "new")
end

function slot0._refreshHelp(slot0)
	gohelper.setActive(slot0._btnhelp.gameObject, HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character) and (slot0._heroMO and slot0:isOwnHero()))
end

function slot0._takeoffAllTalentCube(slot0)
	HeroRpc.instance:TakeoffAllTalentCubeRequest(slot0._heroMO.heroId)
end

function slot0._addDrag(slot0)
	if not slot0._drag then
		return
	end

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._signatureDrag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._signatureDrag:AddDragListener(slot0._onDrag, slot0)
	slot0._signatureDrag:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0._addListener(slot0)
	slot0._trustclick:AddClickListener(slot0._onOpenTrustTip, slot0)
	slot0._careerclick:AddClickListener(slot0._onOpenCareerTip, slot0)
	slot0._signatureClick:AddClickListener(slot0._switchDrawingOnClick, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.TakeoffAllTalentCube, slot0._takeoffAllTalentCube, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._refreshView, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._refreshView, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._refreshView, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._refreshView, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._successDressUpSkin, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._refreshRedDot, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, slot0._onAttributeChanged, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0._onAttributeChanged, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, slot0._showCharacterRankUpView, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, slot0._markFavorSuccess, slot0)
	slot0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0._refreshHelp, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0.onEquipChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, slot0.onEquipChange, slot0)
end

function slot0._markFavorSuccess(slot0)
	slot0._heroMO = HeroModel.instance:getByHeroId(slot0._heroMO.heroId)

	slot0:_refreshBtn()
end

function slot0._onApplicationPause(slot0, slot1)
	if slot1 then
		slot0:_resetSpinePos(false)
	end
end

function slot0._setModelVisible(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._delaySetModelHide, slot0)

	if slot1 then
		slot0._uiSpine:setLayer(UnityLayer.Unit)
		slot0._uiSpine:setModelVisible(slot1)
		slot0._uiSpine:showModelEffect()
	else
		slot0._uiSpine:setLayer(UnityLayer.Water)
		slot0._uiSpine:hideModelEffect()
		TaskDispatcher.runDelay(slot0._delaySetModelHide, slot0, 1)
	end
end

function slot0._delaySetModelHide(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:setModelVisible(false)
	end
end

function slot0._showCharacterRankUpView(slot0, slot1)
	if not slot0._uiSpine then
		return
	end

	slot0:_setModelVisible(false)

	if slot1 then
		slot0:playCloseViewAnim(slot1)
	end
end

function slot0._onOpenView(slot0, slot1)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.CharacterRankUpResultView and slot0._uiSpine then
		slot0._uiSpine:hideModelEffect()
	end

	if slot1 ~= ViewName.CharacterGetView then
		return
	end

	if slot0._uiSpine then
		slot0:_setModelVisible(false)
	end
end

function slot0._successDressUpSkin(slot0)
	slot0.needSwitchSkin = true
end

function slot0._onCloseView(slot0, slot1)
	if ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:setShaderKeyWord()

		if slot0.needSwitchSkin then
			slot0:_refreshSkin()

			slot0.needSwitchSkin = false
		end
	end

	if slot1 == ViewName.CharacterLevelUpView then
		gohelper.setActive(slot0._goattributenode, true)
		slot0._animatorattributetipsnode:Play("close", 0, 0)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:setShaderKeyWord()
	end

	if slot1 == ViewName.CharacterRankUpResultView and slot0._uiSpine then
		slot0._uiSpine:showModelEffect()
	end

	if slot1 ~= ViewName.CharacterGetView then
		return
	end

	if not slot0._uiSpine then
		return
	end

	slot0:_setModelVisible(true)
end

function slot0._onOpenFullView(slot0, slot1)
	if not slot0._uiSpine or slot1 == ViewName.CharacterView then
		return
	end

	slot0:_setModelVisible(false)
end

function slot0._onOpenFullViewFinish(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not slot0._uiSpine or slot1 == ViewName.CharacterView then
		return
	end

	if slot1 ~= ViewName.CharacterView then
		slot0._uiSpine:stopVoice()
	else
		return
	end

	slot0:_setModelVisible(slot0.viewContainer._isVisible)
end

function slot0._onCloseFullView(slot0, slot1)
	if slot0._animator and slot0:isEnterCharacterView() then
		slot0:playAnim(UIAnimationName.Open)
		slot0.viewContainer:getEquipView():playOpenAnim()
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not slot0._uiSpine then
		return
	end

	slot0:_setModelVisible(slot0.viewContainer._isVisible)
	slot0:_checkGuide()
end

function slot0.isEnterCharacterView(slot0)
	for slot5 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if ViewMgr.instance:getSetting(slot1[slot5]).layer == ViewMgr.instance:getSetting(slot0.viewName).layer then
			return slot1[slot5] == slot0.viewName
		end
	end

	return false
end

function slot0.onOpenFinish(slot0)
	slot0:_addDrag()

	slot0._isOpenFinish = true

	if slot0._spineLoadedFinish then
		slot0:_onSpineLoaded()
	end

	if not GuideModel.instance:isGuideRunning(GuideEnum.VerticalDrawingSwitchingGuide) or not slot0._showSwitchDrawingGuide then
		slot1 = slot0.viewContainer.helpShowView

		slot1:setHelpId(HelpEnum.HelpId.Character)
		slot1:setDelayTime(0.5)
		slot1:tryShowHelp()
	end
end

function slot0._onOpenTrustTip(slot0)
	logNormal("打开信赖值tip, 达到下一百分比羁绊值需要 " .. slot0.nextFaith .. " 的羁绊值")
end

function slot0._onOpenCareerTip(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_switch)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function slot0._closeLevelUpview(slot0)
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:_closeLevelUpview()
	slot0:closeThis()
end

function slot0._btnhomeOnClick(slot0)
	slot0:_closeLevelUpview()
	NavigateButtonsView.homeClick()
end

function slot0._btndataOnClick(slot0)
	slot0:_closeLevelUpview()
	slot0:playCloseViewAnim(function ()
		CharacterController.instance:openCharacterDataView(uv0._heroMO.heroId)
	end)
end

function slot0._btnskinOnClick(slot0)
	slot0:_closeLevelUpview()

	if slot0._uiSpine then
		slot0:_setModelVisible(false)
	end

	slot0:playCloseViewAnim(function ()
		CharacterController.instance:openCharacterSkinView(uv0._heroMO)
	end)
end

function slot0._btnfavorOnClick(slot0)
	if not slot0._heroMO.isFavor and CommonConfig.instance:getConstNum(ConstEnum.MaxFavorHeroCount) <= #HeroModel.instance:getAllFavorHeros() then
		GameFacade.showToast(ToastEnum.OverFavorMaxCount)

		return
	end

	HeroRpc.instance:setMarkHeroFavorRequest(slot0._heroMO.heroId, slot1)
end

function slot0._btnhelpOnClick(slot0)
	slot0:_closeLevelUpview()
	HelpController.instance:showHelp(HelpEnum.HelpId.Character)
end

function slot0._btnattributeOnClick(slot0)
	CharacterController.instance:openCharacterTipView({
		tag = "attribute",
		heroMo = slot0._heroMO,
		heroid = slot0._heroMO.heroId,
		equips = slot0._heroMO.defaultEquipUid ~= "0" and {
			slot0._heroMO.defaultEquipUid
		} or nil,
		trialEquipMo = slot0._heroMO.trialEquipMo
	})
end

function slot0._btnlevelOnClick(slot0)
	CharacterController.instance:openCharacterLevelUpView(slot0._heroMO, ViewName.CharacterView)
	slot0._animatorattributetipsnode:Play("open", 0, 0)
	gohelper.setActive(slot0._goattributenode, false)
end

function slot0._btnrankOnClick(slot0)
	if not slot0._uiSpine then
		return
	end

	slot0:_setModelVisible(false)
	slot0:playCloseViewAnim(function ()
		CharacterController.instance:openCharacterRankUpView(uv0._heroMO)
	end)
end

function slot0._btnpassiveskillOnClick(slot0)
	CharacterController.instance:openCharacterTipView({
		tag = "passiveskill",
		heroid = slot0._heroMO.heroId,
		anchorParams = {
			Vector2.New(1, 0.5),
			Vector2.New(1, 0.5)
		},
		tipPos = Vector2.New(-292, -51.1),
		buffTipsX = -770,
		heroMo = slot0._heroMO
	})
end

function slot0._btnexskillOnClick(slot0)
	if slot0._heroMO and slot0._heroMO:isNoShowExSkill() then
		GameFacade.showToast(ToastEnum.TrialHeroClickExSkill)

		return
	end

	slot0:playCloseViewAnim(function ()
		CharacterController.instance:openCharacterExSkillView({
			heroId = uv0._heroMO.heroId,
			heroMo = uv0._heroMO,
			fromHeroDetailView = uv0._fromHeroDetailView,
			hideTrialTip = uv0._hideTrialTip
		})
	end)
end

function slot0._btntalentOnClick(slot0)
	if slot0._heroMO:isOtherPlayerHero() and not slot0._heroMO:getOtherPlayerIsOpenTalent() then
		GameFacade.showToast(ToastEnum.TalentNotUnlock)

		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or slot0._heroMO:isTrial() or slot1 then
		if slot0._heroMO.rank < CharacterEnum.TalentRank then
			if slot0._heroMO.config.heroType == CharacterEnum.HumanHeroType then
				GameFacade.showToast(ToastEnum.CharacterType6, slot0._heroMO.config.name)
			else
				GameFacade.showToast(ToastEnum.Character, slot0._heroMO.config.name)
			end

			return
		end

		if not slot0:isOwnHero() then
			CharacterController.instance:openCharacterTalentTipView({
				open_type = 0,
				isTrial = true,
				hero_id = slot0._heroMO.heroId,
				hero_mo = slot0._heroMO,
				isOwnHero = slot3
			})

			return
		end

		CharacterController.instance:setTalentHeroId(slot0._heroMO.heroId)
		slot0:playCloseViewAnim(function ()
			CharacterController.instance:openCharacterTalentView({
				heroid = uv0._heroMO.heroId,
				heroMo = uv0._heroMO
			})
		end)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Talent))
	end
end

function slot0._switchDrawingOnClick(slot0)
	if not slot0._enableSwitchDrawing or slot0._isDragingSpine then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	CharacterDataConfig.instance:setCharacterDrawingState(slot1.characterId, (CharacterDataConfig.instance:getCharacterDrawingState(SkinConfig.instance:getSkinCo(slot0._heroMO.skin).characterId) ~= CharacterEnum.DrawingState.Static or CharacterEnum.DrawingState.Dynamic) and CharacterEnum.DrawingState.Static)
	slot0:_refreshDrawingState()
end

function slot0._initExternalParams(slot0)
	slot0._hideHomeBtn = uv0._externalParam and slot1.hideHomeBtn
	slot0._isOwnHero = slot1 and slot1.isOwnHero
	slot0._fromHeroDetailView = slot1 and slot1.fromHeroDetailView
	slot0._hideTrialTip = slot1 and slot1.hideTrialTip

	slot0.viewContainer:setIsOwnHero(slot1)

	uv0._externalParam = nil
end

function slot0.onOpen(slot0)
	slot0:_initExternalParams()

	slot0._heroMO = slot0.viewParam
	slot0._playGreetingVoices = true
	slot0._spineNeedHide = true

	slot0:_refreshView()
	NavigateMgr.instance:addEscape(ViewName.CharacterView, slot0._btncloseOnClick, slot0)
	slot0:_checkGuide()
end

function slot0._refreshRedDot(slot0)
	if not slot0:isOwnHero() then
		gohelper.setActive(slot0._goexskillreddot, false)
		gohelper.setActive(slot0._gorankreddot, false)
		gohelper.setActive(slot0._godatareddot, false)
		slot0:_showRedDot(false)

		return
	end

	gohelper.setActive(slot0._goexskillreddot, CharacterModel.instance:isHeroCouldExskillUp(slot0._heroMO.heroId))
	gohelper.setActive(slot0._gorankreddot, CharacterModel.instance:isHeroCouldRankUp(slot0._heroMO.heroId))
	gohelper.setActive(slot0._godatareddot, CharacterModel.instance:hasCultureRewardGet(slot0._heroMO.heroId) or CharacterModel.instance:hasItemRewardGet(slot0._heroMO.heroId))
	slot0:_refreshTalentRed()
end

function slot0._showRedDot(slot0, slot1, slot2)
	if slot1 then
		gohelper.setActive(slot0._gotalentreddot, true)
		gohelper.setActive(slot0._talentRedType1, slot2 == 1)
		gohelper.setActive(slot0._talentRedNew, slot2 == 2)
	else
		gohelper.setActive(slot0._gotalentreddot, false)
	end
end

function slot0._refreshTalentRed(slot0)
	slot0:_showRedDot(true, slot0._heroMO.isShowTalentStyleRed and 2 or CharacterModel.instance:heroTalentRedPoint(slot0._heroMO.heroId) and 1 or 0)
end

function slot0._refreshView(slot0)
	slot0:_unmarkNew()
	slot0:_refreshBtn()
	slot0:_refreshSkill()
	slot0:_refreshDrawingState()
	slot0:_refreshSpine()
	slot0:_refreshInfo()
	slot0:_refreshCareer()
	slot0:_refreshAttribute()
	slot0:_refreshLevel()
	slot0:_refreshRank()
	slot0:_refreshPassiveSkill()
	slot0:_refreshExSkill()
	slot0:_refreshTalent()
	slot0:_refreshSignature()
	slot0:_refreshRedDot()
end

function slot0.isOwnHero(slot0)
	if slot0._isOwnHero ~= nil then
		return slot0._isOwnHero
	end

	return slot0._heroMO and slot0._heroMO:isOwnHero()
end

function slot0._refreshBtn(slot0)
	slot1 = slot0:isOwnHero()

	gohelper.setActive(slot0._btnhome.gameObject, not slot0._hideHomeBtn)
	gohelper.setActive(slot0._btnhelp.gameObject, HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character) and slot1)
	gohelper.setActive(slot0._btnskin.gameObject, CharacterEnum.SkinOpen and slot1)
	gohelper.setActive(slot0._btnfavor.gameObject, slot1)
	gohelper.setActive(slot0._btndata.gameObject, slot1)
	gohelper.setActive(slot0._btnlevel.gameObject, slot1)
	gohelper.setActive(slot0._btnrank.gameObject, slot1)
	gohelper.setActive(slot0._golevelimage, slot1)
	gohelper.setActive(slot0._golevelicon.gameObject, slot1)
	gohelper.setActive(slot0._gorankicon, slot1)
	gohelper.setActive(slot0._gorankimage, slot1)
	gohelper.setActive(slot0._golevelimagetrial, not slot1)
	gohelper.setActive(slot0._gorankimagetrial, not slot1)

	if not slot1 and not slot0._hasMoveIcon then
		recthelper.setAnchorX(slot0._gorankeyes.transform, recthelper.getAnchorX(slot0._gorankeyes.transform) + uv0.RankIconOffset)
		recthelper.setAnchorX(slot0._goranklights.transform, recthelper.getAnchorX(slot0._goranklights.transform) + uv0.RankIconOffset)

		slot0._hasMoveIcon = true
	end

	UISpriteSetMgr.instance:setCommonSprite(slot0._imagefavor, slot0._heroMO.isFavor and "btn_favor_light" or "btn_favor_dark")
end

function slot0._refreshSkin(slot0)
	slot0._spineNeedHide = true

	slot0:_refreshDrawingState()
	slot0:_refreshSpine()
end

function slot0._unmarkNew(slot0)
	if slot0._heroMO and slot0._heroMO.isNew then
		HeroRpc.instance:sendUnMarkIsNewRequest(slot0._heroMO.heroId)
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._startPos = slot2.position.x

	slot0:playAnim(UIAnimationName.SwitchClose)

	slot0._isDragingSpine = true

	if slot0._uiSpine then
		slot0._uiSpine:showDragEffect(false)
	end
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._isDragingSpine then
		return
	end

	recthelper.setAnchorX(slot0._goherocontainer.transform, recthelper.getAnchorX(slot0._goherocontainer.transform) + slot2.delta.x * 1)

	slot0._herocontainerCanvasGroup.alpha = 1 - Mathf.Abs(slot0._startPos - slot2.position.x) * 0.001
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if not slot0._isDragingSpine then
		return
	end

	if slot0._uiSpine then
		slot0._uiSpine:showDragEffect(true)
	end

	slot4 = false
	slot5 = false

	if slot0._startPos < slot2.position.x and slot3 - slot0._startPos >= 300 then
		if CharacterBackpackCardListModel.instance:getLastCharacterCard(slot0._heroMO.heroId) then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

			slot0._heroMO = slot6
			slot0.viewContainer.viewParam = slot0._heroMO
			slot0._playGreetingVoices = true
			slot0._delayPlayVoiceTime = 0.3
			slot5 = true
			slot0._spineNeedHide = true

			slot0:_refreshView()
			CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, slot0._heroMO)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, slot0._heroMO)
		end
	elseif slot3 < slot0._startPos and slot0._startPos - slot3 >= 300 and CharacterBackpackCardListModel.instance:getNextCharacterCard(slot0._heroMO.heroId) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

		slot0._heroMO = slot6
		slot0.viewContainer.viewParam = slot0._heroMO
		slot0._playGreetingVoices = true
		slot0._delayPlayVoiceTime = 0.3
		slot5 = true
		slot0._spineNeedHide = true

		slot0:_refreshView()
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, slot0._heroMO)
		CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, slot0._heroMO)

		slot4 = true
	end

	slot0:_resetSpinePos(slot5, slot4)

	slot0._isDragingSpine = false
end

function slot0._resetSpinePos(slot0, slot1, slot2)
	slot6 = recthelper.getAnchorX(slot0._goherocontainer.transform)

	if slot1 then
		recthelper.setAnchorX(slot0._goherocontainer.transform, slot2 and -800 or 800)
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._goherocontainer.transform)

	slot9 = slot1 and 0.5 or 0.3

	if slot0._dragTweenId then
		ZProj.TweenHelper.KillById(slot0._dragTweenId)
	end

	slot0._dragTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._goherocontainer.transform, slot0._originSpineRootPosX, slot9, nil, slot0, nil, EaseType.OutQuart)

	slot0:playAnim(UIAnimationName.SwitchOpen)
	slot0.viewContainer:getEquipView():playOpenAnim()

	slot0._herocontainerCanvasGroup.alpha = 1
end

function slot0._refreshSignature(slot0)
	slot0._simagesignature:UnLoadImage()
	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot0._heroMO.config.signature))
end

function slot0._refreshSpine(slot0)
	if slot0._uiSpine then
		TaskDispatcher.cancelTask(slot0._playSpineVoice, slot0)
		slot0._uiSpine:onDestroy()
		slot0._uiSpine:stopVoice()

		slot0._uiSpine = nil
	end

	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)
	slot1 = SkinConfig.instance:getSkinCo(slot0._heroMO.skin)

	slot0._uiSpine:setResPath(slot1, slot0._onSpineLoaded, slot0)

	slot2 = SkinConfig.instance:getSkinOffset(slot1.characterViewOffset)

	recthelper.setAnchor(slot0._gospine.transform, tonumber(slot2[1]), tonumber(slot2[2]))
	transformhelper.setLocalScale(slot0._gospine.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))

	slot3 = SkinConfig.instance:getSkinOffset(slot1.haloOffset)
	slot6 = tonumber(slot3[3])

	recthelper.setAnchor(slot0._simageplayerbg.transform, tonumber(slot3[1]), tonumber(slot3[2]))
	transformhelper.setLocalScale(slot0._simageplayerbg.transform, slot6, slot6, slot6)
end

function slot0._onSpineLoaded(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:initSkinDragEffect(slot0._heroMO.skin)
	end

	slot0._spineLoadedFinish = true

	if not slot0._isOpenFinish then
		return
	end

	if not slot0._playGreetingVoices then
		return
	end

	if not slot0._uiSpine then
		return
	end

	if not slot0._gospine.activeInHierarchy then
		return
	end

	slot0._playGreetingVoices = nil
	slot2 = CharacterDataConfig.instance:getCharacterDrawingState(slot0._heroMO.heroId)

	if ViewMgr.instance:isOpen(ViewName.CharacterRankUpView) then
		return
	end

	if slot2 == CharacterEnum.DrawingState.Dynamic then
		if slot0:isOwnHero() then
			slot0._greetingVoices = HeroModel.instance:getVoiceConfig(slot1, CharacterEnum.VoiceType.Greeting)
		else
			slot0._greetingVoices = {}

			if CharacterDataConfig.instance:getCharacterVoicesCo(slot1) then
				for slot7, slot8 in pairs(slot3) do
					if slot8.type == CharacterEnum.VoiceType.Greeting and CharacterDataConfig.instance:checkVoiceSkin(slot8, slot0._heroMO.skin) then
						table.insert(slot0._greetingVoices, slot8)
					end
				end
			end
		end

		if slot0._greetingVoices and #slot0._greetingVoices > 0 then
			TaskDispatcher.cancelTask(slot0._playSpineVoice, slot0)
			TaskDispatcher.runDelay(slot0._playSpineVoice, slot0, slot0._delayPlayVoiceTime or 0)

			slot0._delayPlayVoiceTime = 0
		end
	end
end

function slot0._playSpineVoice(slot0)
	if not slot0._uiSpine then
		return
	end

	slot0._uiSpine:playVoice(slot0._greetingVoices[1], nil, slot0._txtanacn, slot0._txtanaen, slot0._gocontentbg)
end

function slot0._refreshDrawingState(slot0)
	slot1 = false

	if SkinConfig.instance:getSkinCo(slot0._heroMO.skin).showDrawingSwitch == 1 then
		slot0._enableSwitchDrawing = true

		if CharacterDataConfig.instance:getCharacterDrawingState(slot2.characterId) == CharacterEnum.DrawingState.Static then
			slot1 = true
		end
	else
		slot0._enableSwitchDrawing = false

		CharacterDataConfig.instance:setCharacterDrawingState(slot2.characterId, CharacterEnum.DrawingState.Dynamic)
	end

	if slot0._heroMO.isSettingSkinOffset then
		slot1 = true
	end

	if slot0._spineNeedHide and slot1 then
		gohelper.setActive(slot0._godynamiccontainer, false)
	else
		gohelper.setActive(slot0._godynamiccontainer, true)
	end

	slot0._spineNeedHide = false
	slot3 = slot1 and 0.01 or 1

	transformhelper.setLocalScale(slot0._godynamiccontainer.transform, slot3, slot3, slot3)

	if not slot1 then
		slot0._uiSpine:hideModelEffect()
		slot0._uiSpine:showModelEffect()
	end

	gohelper.setActive(slot0._gostaticcontainer, slot1)

	if slot1 then
		slot0._playGreetingVoices = nil

		if slot0._uiSpine then
			slot0._uiSpine:stopVoice()
		end

		slot0._simagestatic:LoadImage(ResUrl.getHeadIconImg(slot2.drawing), slot0._loadedImage, slot0)
	else
		slot0._simagestatic:UnLoadImage()
		slot0:_setModelVisible(true)
	end

	gohelper.setActive(slot0._gopifu, slot0._enableSwitchDrawing)
end

function slot0._checkGuide(slot0)
	slot0._showSwitchDrawingGuide = false

	if not slot0._enableSwitchDrawing then
		return
	end

	if not slot0.viewContainer._isVisible then
		return
	end

	slot1 = false

	for slot6, slot7 in ipairs(HeroModel.instance:getList()) do
		if slot7.rank > 1 and slot7.config.rare >= 3 then
			slot1 = true

			break
		end
	end

	if slot1 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideSwitchDrawing)
	end

	slot0._showSwitchDrawingGuide = slot1
end

function slot0._loadedImage(slot0)
	gohelper.onceAddComponent(slot0._simagestatic.gameObject, gohelper.Type_Image):SetNativeSize()

	if not string.nilorempty(SkinConfig.instance:getSkinCo(slot0._heroMO.skin).characterViewImgOffset) then
		slot3 = string.splitToNumber(slot2, "#")

		recthelper.setAnchor(slot0._simagestatic.transform, tonumber(slot3[1]), tonumber(slot3[2]))
		transformhelper.setLocalScale(slot0._simagestatic.transform, tonumber(slot3[3]), tonumber(slot3[3]), tonumber(slot3[3]))
	else
		recthelper.setAnchor(slot0._simagestatic.transform, 0, 0)
		transformhelper.setLocalScale(slot0._simagestatic.transform, 1, 1, 1)
	end
end

function slot0._refreshInfo(slot0)
	for slot4 = 1, 6 do
		gohelper.setActive(slot0._rareStars[slot4], slot4 <= CharacterEnum.Star[slot0._heroMO.config.rare])
	end

	UISpriteSetMgr.instance:setCharactergetSprite(slot0._imagecareericon, "charactercareer" .. tostring(slot0._heroMO.config.career))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagedmgtype, "dmgtype" .. tostring(slot0._heroMO.config.dmgType))

	slot1 = slot0:_getFaithPercent()
	slot0._txttrust.text = slot1 * 100 .. "%"

	slot0._slidertrust:SetValue(slot1)

	slot0._txtnamecn.text = slot0._heroMO:getHeroName()
	slot0._txtnameen.text = slot0._heroMO.config.nameEng
	slot0._txttalentcn.text = luaLang("talent_character_talentcn" .. CharacterEnum.TalentTxtByHeroType[slot0._heroMO.config.heroType])
	slot0._txttalenten.text = luaLang("talent_character_talenten" .. CharacterEnum.TalentTxtByHeroType[slot0._heroMO.config.heroType])
end

function slot0._getFaithPercent(slot0)
	slot1 = HeroConfig.instance:getFaithPercent(slot0._heroMO.faith)
	slot0.nextFaith = slot1[2]

	return slot1[1]
end

function slot0._refreshCareer(slot0)
	slot2 = {}

	if not string.nilorempty(slot0._heroMO.config.battleTag) then
		slot2 = string.split(slot1, "#")
	end

	for slot6 = 1, 3 do
		if slot6 <= #slot2 then
			slot0._careerlabels[slot6].text = HeroConfig.instance:getBattleTagConfigCO(slot2[slot6]).tagName
		else
			slot0._careerlabels[slot6].text = ""
		end
	end
end

function slot0._onAttributeChanged(slot0, slot1, slot2)
	if not slot2 or slot2 == slot0._heroMO.heroId then
		slot0:_refreshAttribute(slot1)
	end
end

function slot0.onEquipChange(slot0)
	if not slot0.viewParam:hasDefaultEquip() then
		return
	end

	slot0:_refreshAttribute()
end

function slot0._refreshAttribute(slot0, slot1)
	slot2 = slot0._heroMO
	slot3 = slot2:getHeroBaseAttrDict(slot1)
	slot4 = HeroConfig.instance:talentGainTab2IDTab(slot2:getTalentGain(slot1))
	slot6 = slot2.destinyStoneMo:getAddAttrValues()
	slot7 = {
		[slot12] = 0
	}

	for slot11, slot12 in ipairs(uv0.AttrIdList) do
		-- Nothing
	end

	if not slot0._heroMO:isOtherPlayerHero() and slot0._heroMO:hasDefaultEquip() then
		slot10 = slot0._heroMO and slot0._heroMO:getTrialEquipMo() or EquipModel.instance:getEquip(slot0._heroMO.defaultEquipUid)
		slot7[CharacterEnum.AttrId.Hp], slot7[CharacterEnum.AttrId.Attack], slot7[CharacterEnum.AttrId.Defense], slot7[CharacterEnum.AttrId.Mdefense] = EquipConfig.instance:getEquipAddBaseAttr(slot10)

		for slot19, slot20 in ipairs(uv0.AttrIdList) do
			if EquipConfig.instance:getEquipBreakAddAttrValueDict(slot10.config, slot10.breakLv)[slot20] ~= 0 then
				slot7[slot20] = slot7[slot20] + math.floor(slot21 / 100 * slot3[slot20])
			end
		end
	end

	for slot13, slot14 in ipairs(uv0.AttrIdList) do
		slot17 = slot3[slot14] + slot7[slot14] + (slot4[slot14] and slot4[slot14].value and math.floor(slot4[slot14].value) or 0) + (slot5 and slot5:getAddValueByAttrId(slot6, slot14) or 0)
		slot0._attributevalues[slot13].value.text = slot17
		slot18 = HeroConfig.instance:getHeroAttributeCO(slot14)
		slot0._attributevalues[slot13].name.text = slot18.name

		CharacterController.instance:SetAttriIcon(slot0._attributevalues[slot13].icon, slot14, uv0.AttrIconColor)

		slot19 = slot0._levelUpAttributeValues[slot13]
		slot19.value.text = slot17
		slot19.name.text = slot18.name

		CharacterController.instance:SetAttriIcon(slot19.icon, slot14, uv0.AttrIconColor)
	end
end

function slot0._refreshAttributeTips(slot0, slot1)
	slot3 = slot0._heroMO.level

	if not slot1 or slot1 < slot3 then
		for slot7, slot8 in ipairs(slot0._levelUpAttributeValues) do
			slot8.newValue.text = 0
		end

		return
	end

	slot4 = slot1 == slot3
	slot5 = slot2:getHeroBaseAttrDict(slot1)
	slot6 = HeroConfig.instance:talentGainTab2IDTab(slot2:getTalentGain(slot1))
	slot8 = slot2.destinyStoneMo:getAddAttrValues()
	slot9 = {
		[slot14] = 0
	}

	for slot13, slot14 in ipairs(uv0.AttrIdList) do
		-- Nothing
	end

	if slot2:hasDefaultEquip() then
		slot11 = EquipModel.instance:getEquip(slot2.defaultEquipUid)
		slot9[CharacterEnum.AttrId.Hp], slot9[CharacterEnum.AttrId.Attack], slot9[CharacterEnum.AttrId.Defense], slot9[CharacterEnum.AttrId.Mdefense] = EquipConfig.instance:getEquipAddBaseAttr(slot11)
		slot20 = slot11.breakLv

		for slot20, slot21 in ipairs(uv0.AttrIdList) do
			if EquipConfig.instance:getEquipBreakAddAttrValueDict(slot11.config, slot20)[slot21] ~= 0 then
				slot9[slot21] = slot9[slot21] + math.floor(slot22 / 100 * slot5[slot21])
			end
		end
	end

	for slot14, slot15 in ipairs(uv0.AttrIdList) do
		slot0._levelUpAttributeValues[slot14].newValue.text = slot5[slot15] + slot9[slot15] + (slot6[slot15] and slot6[slot15].value and math.floor(slot6[slot15].value) or 0) + (slot7 and slot7:getAddValueByAttrId(slot8, slot15) or 0)
		slot21 = slot4 and "#C7C3C0" or "#65B96F"
		slot20.color = GameUtil.parseColor(slot21)
		slot19.newValueArrow.color = GameUtil.parseColor(slot21)
	end
end

function slot0._refreshLevel(slot0)
	slot2 = HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1])
	slot3 = HeroConfig.instance:getShowLevel(slot0._heroMO.level) .. "/"

	if slot0._heroMO:getIsBalance() then
		slot3 = string.format("<color=#81abe5>%s</color>/", slot1)
	end

	slot0._txtlevel.text = slot3
	slot0._txtlevelmax.text = slot2
end

function slot0._refreshRank(slot0)
	slot2 = slot0._heroMO.rank

	for slot7 = 1, 3 do
		gohelper.setActive(slot0._ranklights[slot7].go, HeroConfig.instance:getMaxRank(slot0._heroMO.config.rare) == slot7)

		for slot11 = 1, slot7 do
			if slot11 <= slot2 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(slot0._ranklights[slot7].lights[slot11]:GetComponent("Image"), "#feb73b")
			else
				SLFramework.UGUI.GuiHelper.SetColor(slot0._ranklights[slot7].lights[slot11]:GetComponent("Image"), "#737373")
			end
		end
	end
end

function slot0._refreshSkill(slot0)
	slot0._skillContainer:onUpdateMO(slot0._heroMO.heroId, nil, slot0._heroMO)
end

function slot0._refreshPassiveSkill(slot0)
	if not lua_skill.configDict[slot0._heroMO:getpassiveskillsCO()[1].skillPassive] then
		logError("找不到被动技能, skillId: " .. tostring(slot3))

		return
	end

	slot0._txtpassivename.text = slot4.name

	for slot8 = 1, #slot1 do
		slot9 = CharacterModel.instance:isPassiveUnlockByHeroMo(slot0._heroMO, slot8)

		gohelper.setActive(slot0._passiveskillitems[slot8].on, slot9)
		gohelper.setActive(slot0._passiveskillitems[slot8].off, not slot9)
		gohelper.setActive(slot0._passiveskillitems[slot8].go, true)
	end

	for slot8 = #slot1 + 1, #slot0._passiveskillitems do
		gohelper.setActive(slot0._passiveskillitems[slot8].go, false)
	end
end

function slot0._refreshExSkill(slot0)
	for slot4 = 1, 5 do
		if slot4 <= slot0._heroMO.exSkillLevel then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._exskills[slot4]:GetComponent("Image"), "#feb73b")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot0._exskills[slot4]:GetComponent("Image"), "#737373")
		end
	end
end

function slot0._refreshTalent(slot0)
	slot3 = false
	slot5 = nil
	slot3 = (not slot0._heroMO:isOtherPlayerHero() or slot0._heroMO:getOtherPlayerIsOpenTalent()) and (OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or slot0._heroMO:isTrial())

	gohelper.setActive(slot0._gotalent, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Talent) or not slot0._heroMO:isOwnHero())
	gohelper.setActive(slot0._gotalentlock, not slot3)
	ZProj.UGUIHelper.SetGrayscale(slot0._gotalents, not slot3)
	slot0:_showTalentStyleBtn()

	slot0._txttalentvalue.text = HeroResonanceConfig.instance:getTalentConfig(slot0._heroMO.heroId, slot0._heroMO.talent + 1) and slot0._heroMO.talent or luaLang("character_max_overseas")
end

function slot0._showTalentStyleBtn(slot0)
	slot2 = TalentStyleModel.instance:isUnlockStyleSystem(slot0._heroMO.talent)

	if not slot0._heroMO:isOwnHero() and not slot2 and not slot2 then
		slot0:_showTalentBtn()

		return
	end

	slot4 = slot0._heroMO.talentCubeInfos:getMainCubeMo()

	if slot0._heroMO:getHeroUseCubeStyleId() == 0 or not slot4 then
		slot0:_showTalentBtn()

		return
	end

	if HeroResonanceConfig.instance:getTalentStyle(slot4.id) and slot6[slot3] then
		slot8, slot9 = slot7:getStyleTagIcon()
		slot0._imageicon.color = GameUtil.parseColor(slot7._styleCo.color)

		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._imageicon, slot9)
		gohelper.setActive(slot0._gotalentstyle, true)
		gohelper.setActive(slot0._gotalents, false)
	else
		slot0:_showTalentBtn()
	end
end

function slot0._showTalentBtn(slot0)
	gohelper.setActive(slot0._gotalentstyle, false)
	gohelper.setActive(slot0._gotalents, true)
end

function slot0._onRefreshStyleIcon(slot0)
	slot0:_showTalentStyleBtn()
end

function slot0.onClose(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()
		slot0._drag:RemoveDragListener()
	end

	if slot0._signatureDrag then
		slot0._signatureDrag:RemoveDragBeginListener()
		slot0._signatureDrag:RemoveDragEndListener()
		slot0._signatureDrag:RemoveDragListener()
	end

	slot0._trustclick:RemoveClickListener()
	slot0._careerclick:RemoveClickListener()
	slot0._signatureClick:RemoveClickListener()

	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end

	if slot0._dragTweenId then
		ZProj.TweenHelper.KillById(slot0._dragTweenId)

		slot0._dragTweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._playSpineVoice, slot0)
	TaskDispatcher.cancelTask(slot0._delaySetModelHide, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0._playGreetingVoices = true

	slot0:clear()
	slot0:_refreshView()
end

function slot0.clear(slot0)
	slot0._simagestatic:UnLoadImage()
	slot0._simagesignature:UnLoadImage()
end

function slot0.playCloseViewAnim(slot0, slot1)
	if slot0._tempFunc then
		TaskDispatcher.cancelTask(slot0._tempFunc, slot0)
	end

	slot0:playAnim(UIAnimationName.Close)

	slot0._tempFunc = slot1

	UIBlockMgr.instance:startBlock(slot0.viewName .. "ViewCloseAnim")
	TaskDispatcher.runDelay(slot0._closeAnimFinish, slot0, 0.18)
end

function slot0._closeAnimFinish(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "ViewCloseAnim")
	slot0:_tempFunc()
end

function slot0.playAnim(slot0, slot1)
	slot0._isAnim = true

	slot0:setShaderKeyWord()
	slot0._animator:Play(slot1, slot0.onAnimDone, slot0)
end

function slot0.onAnimDone(slot0)
	slot0._isAnim = false

	slot0:setShaderKeyWord()
end

function slot0.setShaderKeyWord(slot0)
	if slot0._isDragingSpine or slot0._isAnim then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function slot0.onDestroyView(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	slot0._simageplayerbg:UnLoadImage()
	slot0._simagebg:UnLoadImage()
	slot0:clear()
	TaskDispatcher.cancelTask(slot0._closeAnimFinish, slot0)
	TaskDispatcher.cancelTask(slot0._delaySetModelHide, slot0)
	TaskDispatcher.cancelTask(slot0._playSpineVoice, slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

return slot0
