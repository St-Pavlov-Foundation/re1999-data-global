module("modules.logic.character.view.CharacterView", package.seeall)

local var_0_0 = class("CharacterView", BaseView)
local var_0_1 = 5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bgcanvas/bg/#simage_bg")
	arg_1_0._simageplayerbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bgcanvas/bg/#simage_playerbg")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "anim/#go_herocontainer/dynamiccontainer/#go_spine")
	arg_1_0._simagestatic = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/#go_herocontainer/staticcontainer/#simage_static")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_close")
	arg_1_0._btnhome = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_home")
	arg_1_0._btndata = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_data")
	arg_1_0._godatareddot = gohelper.findChild(arg_1_0.viewGO, "anim/go_btns/#btn_data/#go_datareddot")
	arg_1_0._btnskin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_skin")
	arg_1_0._btnfavor = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_favor")
	arg_1_0._imagefavor = gohelper.findChildImage(arg_1_0.viewGO, "anim/go_btns/#btn_favor")
	arg_1_0._btnhelp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_help")
	arg_1_0._btnrecommed = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_recommed")
	arg_1_0._gorare = gohelper.findChild(arg_1_0.viewGO, "anim/info/#go_rare")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "anim/info/#image_careericon")
	arg_1_0._imagedmgtype = gohelper.findChildImage(arg_1_0.viewGO, "anim/info/#image_dmgtype")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "anim/info/#txt_namecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "anim/info/#txt_namecn/#txt_nameen")
	arg_1_0._txttrust = gohelper.findChildText(arg_1_0.viewGO, "anim/info/trust/#txt_trust")
	arg_1_0._slidertrust = gohelper.findChildSlider(arg_1_0.viewGO, "anim/info/trust/#slider_trust")
	arg_1_0._gocareer = gohelper.findChild(arg_1_0.viewGO, "anim/#go_career")
	arg_1_0._btnattribute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/attribute/#btn_attribute")
	arg_1_0._goattributenode = gohelper.findChild(arg_1_0.viewGO, "anim/attribute")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "anim/attribute/#go_attribute")
	arg_1_0._goattributetipsnode = gohelper.findChild(arg_1_0.viewGO, "anim/#go_attributetips")
	arg_1_0._animatorattributetipsnode = arg_1_0._goattributetipsnode:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goattributetips = gohelper.findChild(arg_1_0.viewGO, "anim/#go_attributetips/#go_attribute")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "anim/level/lvtxt/#txt_level")
	arg_1_0._txtlevelmax = gohelper.findChildText(arg_1_0.viewGO, "anim/level/lvtxt/#txt_level/#txt_levelmax")
	arg_1_0._btnlevel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/level/#btn_level")
	arg_1_0._gorankeyes = gohelper.findChild(arg_1_0.viewGO, "anim/rank/#go_rankeyes")
	arg_1_0._goranklights = gohelper.findChild(arg_1_0.viewGO, "anim/rank/#go_ranklights")
	arg_1_0._btnrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/rank/#btn_rank")
	arg_1_0._gorankreddot = gohelper.findChild(arg_1_0.viewGO, "anim/rank/#go_rankreddot")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "anim/layout/#go_skillLayout/#go_skill")
	arg_1_0._btnpassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/passiveskill/#btn_passiveskill")
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "anim/passiveskill/bg/passiveskillimage/#txt_passivename")
	arg_1_0._gopassiveskills = gohelper.findChild(arg_1_0.viewGO, "anim/passiveskill/#go_passiveskills")
	arg_1_0._btnexskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/layout/rightbottom/exskill/#btn_exskill")
	arg_1_0._goexskills = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/exskill/#go_exskills")
	arg_1_0._goexskillreddot = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/exskill/#go_exskillreddot")
	arg_1_0._gotalent = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent")
	arg_1_0._txttalentcn = gohelper.findChildText(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/talentcn")
	arg_1_0._txttalenten = gohelper.findChildText(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/talentcn/talenten")
	arg_1_0._btntalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#btn_talent")
	arg_1_0._gotalents = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talents")
	arg_1_0._gotalentstyle = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentstyle")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentstyle/#image_icon")
	arg_1_0._txttalentvalue = gohelper.findChildText(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#txt_talentvalue")
	arg_1_0._gotalentlock = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentlock")
	arg_1_0._gotalentreddot = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentreddot")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "anim/bottom/#go_contentbg")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "anim/bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "anim/bottom/#txt_ana_en")
	arg_1_0._godynamiccontainer = gohelper.findChild(arg_1_0.viewGO, "anim/#go_herocontainer/dynamiccontainer")
	arg_1_0._gostaticcontainer = gohelper.findChild(arg_1_0.viewGO, "anim/#go_herocontainer/staticcontainer")
	arg_1_0._goherocontainer = gohelper.findChild(arg_1_0.viewGO, "anim/#go_herocontainer")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bottom/#simage_signature")
	arg_1_0._golevelimage = gohelper.findChild(arg_1_0.viewGO, "anim/level/levelimage")
	arg_1_0._golevelicon = gohelper.findChild(arg_1_0.viewGO, "anim/level/addicon")
	arg_1_0._golevelimagetrial = gohelper.findChild(arg_1_0.viewGO, "anim/level/#go_levelimagetrial")
	arg_1_0._gorankimage = gohelper.findChild(arg_1_0.viewGO, "anim/rank/rankimage")
	arg_1_0._gorankicon = gohelper.findChild(arg_1_0.viewGO, "anim/rank/addicon")
	arg_1_0._gorankimagetrial = gohelper.findChild(arg_1_0.viewGO, "anim/rank/#go_rankimagetrial")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnhome:AddClickListener(arg_2_0._btnhomeOnClick, arg_2_0)
	arg_2_0._btndata:AddClickListener(arg_2_0._btndataOnClick, arg_2_0)
	arg_2_0._btnskin:AddClickListener(arg_2_0._btnskinOnClick, arg_2_0)
	arg_2_0._btnfavor:AddClickListener(arg_2_0._btnfavorOnClick, arg_2_0)
	arg_2_0._btnhelp:AddClickListener(arg_2_0._btnhelpOnClick, arg_2_0)
	arg_2_0._btnrecommed:AddClickListener(arg_2_0._btnrecommedOnClick, arg_2_0)
	arg_2_0._btnattribute:AddClickListener(arg_2_0._btnattributeOnClick, arg_2_0)
	arg_2_0._btnlevel:AddClickListener(arg_2_0._btnlevelOnClick, arg_2_0)
	arg_2_0._btnrank:AddClickListener(arg_2_0._btnrankOnClick, arg_2_0)
	arg_2_0._btnpassiveskill:AddClickListener(arg_2_0._btnpassiveskillOnClick, arg_2_0)
	arg_2_0._btnexskill:AddClickListener(arg_2_0._btnexskillOnClick, arg_2_0)
	arg_2_0._btntalent:AddClickListener(arg_2_0._btntalentOnClick, arg_2_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, arg_2_0._onApplicationPause, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, arg_2_0._refreshAttributeTips, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onTalentStyleRead, arg_2_0._refreshTalentRed, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_2_0._onRefreshStyleIcon, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, arg_2_0._onRefreshStyleIcon, arg_2_0)
	arg_2_0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_2_0._onRefreshStyleIcon, arg_2_0)
	arg_2_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_2_0._onRefreshDestiny, arg_2_0)
	arg_2_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, arg_2_0._onRefreshDestiny, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onRefreshCharacterSkill, arg_2_0._refreshSkill, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, arg_2_0._onJumpView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnhome:RemoveClickListener()
	arg_3_0._btndata:RemoveClickListener()
	arg_3_0._btnskin:RemoveClickListener()
	arg_3_0._btnfavor:RemoveClickListener()
	arg_3_0._btnhelp:RemoveClickListener()
	arg_3_0._btnrecommed:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0._btnlevel:RemoveClickListener()
	arg_3_0._btnrank:RemoveClickListener()
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnexskill:RemoveClickListener()
	arg_3_0._btntalent:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.onApplicationPause, arg_3_0._onApplicationPause, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, arg_3_0._refreshAttributeTips, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onTalentStyleRead, arg_3_0._refreshTalentRed, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_3_0._onRefreshStyleIcon, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, arg_3_0._onRefreshStyleIcon, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_3_0._markFavorSuccess, arg_3_0)
	arg_3_0:removeEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_3_0._onRefreshStyleIcon, arg_3_0)
	arg_3_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_3_0._onRefreshDestiny, arg_3_0)
	arg_3_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, arg_3_0._onRefreshDestiny, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onRefreshCharacterSkill, arg_3_0._refreshSkill, arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, arg_3_0._onJumpView, arg_3_0)
end

var_0_0.HpAttrId = 101
var_0_0.AttackAttrId = 102
var_0_0.DefenseAttrId = 103
var_0_0.MdefenseAttrId = 104
var_0_0.TechnicAttrId = 105
var_0_0.RankIconOffset = 51.38
var_0_0.AttrIconColor = GameUtil.parseColor("#9b795e")
var_0_0.AttrIdList = {
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Mdefense,
	CharacterEnum.AttrId.Attack
}

function var_0_0._editableInitView(arg_4_0)
	gohelper.addUIClickAudio(arg_4_0._btnlevel.gameObject, AudioEnum.UI.Play_Ui_Level_Unfold)
	gohelper.addUIClickAudio(arg_4_0._btndata.gameObject, AudioEnum.UI.UI_role_introduce_open)
	gohelper.addUIClickAudio(arg_4_0._btnskin.gameObject, AudioEnum.UI.UI_role_skin_open)
	gohelper.addUIClickAudio(arg_4_0._btnhelp.gameObject, AudioEnum.UI.UI_help_open)
	gohelper.addUIClickAudio(arg_4_0._btnclose.gameObject, AudioEnum.UI.UI_Rolesclose)
	gohelper.addUIClickAudio(arg_4_0._btnhome.gameObject, AudioEnum.UI.UI_Rolesclose)
	gohelper.addUIClickAudio(arg_4_0._btnattribute.gameObject, AudioEnum.UI.Play_ui_role_description)
	gohelper.addUIClickAudio(arg_4_0._btntalent.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(arg_4_0._btnrank.gameObject, AudioEnum.UI.play_ui_role_insight_open)
	gohelper.setActive(arg_4_0._btnskin.gameObject, CharacterEnum.SkinOpen)

	local var_4_0 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(arg_4_0._btnhelp.gameObject, var_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/juese_bj"))
	arg_4_0._simageplayerbg:LoadImage(ResUrl.getCharacterIcon("guangyun"))

	arg_4_0._uiSpine = GuiModelAgent.Create(arg_4_0._gospine, true)

	arg_4_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, arg_4_0.viewName)

	arg_4_0._rareStars = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 6 do
		arg_4_0._rareStars[iter_4_0] = gohelper.findChild(arg_4_0._gorare, "rare" .. iter_4_0)
	end

	arg_4_0._careerlabels = arg_4_0:getUserDataTb_()

	for iter_4_1 = 1, 3 do
		arg_4_0._careerlabels[iter_4_1] = gohelper.findChildText(arg_4_0._gocareer, "careerlabel" .. iter_4_1)
	end

	arg_4_0._attributevalues = {}
	arg_4_0._levelUpAttributeValues = {}

	for iter_4_2 = 1, var_0_1 do
		local var_4_1 = arg_4_0:getUserDataTb_()

		var_4_1.value = gohelper.findChildText(arg_4_0._goattribute, "attribute" .. tostring(iter_4_2) .. "/txt_attribute")
		var_4_1.name = gohelper.findChildText(arg_4_0._goattribute, "attribute" .. tostring(iter_4_2) .. "/name")
		var_4_1.icon = gohelper.findChildImage(arg_4_0._goattribute, "attribute" .. tostring(iter_4_2) .. "/icon")
		var_4_1.rate = gohelper.findChildImage(arg_4_0._goattribute, "attribute" .. tostring(iter_4_2) .. "/rate")

		gohelper.setActive(var_4_1.rate.gameObject, false)

		arg_4_0._attributevalues[iter_4_2] = var_4_1

		local var_4_2 = arg_4_0:getUserDataTb_()
		local var_4_3 = "attribute" .. tostring(iter_4_2)

		var_4_2.value = gohelper.findChildText(arg_4_0._goattributetips, var_4_3 .. "/txt_attribute")
		var_4_2.newValue = gohelper.findChildText(arg_4_0._goattributetips, var_4_3 .. "/txt_attribute/txt_attribute2")
		var_4_2.newValueArrow = gohelper.findChildImage(arg_4_0._goattributetips, var_4_3 .. "/txt_attribute/image_Arrow")
		var_4_2.name = gohelper.findChildText(arg_4_0._goattributetips, var_4_3 .. "/name")
		var_4_2.icon = gohelper.findChildImage(arg_4_0._goattributetips, var_4_3 .. "/icon")
		arg_4_0._levelUpAttributeValues[iter_4_2] = var_4_2
	end

	arg_4_0._ranklights = {}

	for iter_4_3 = 1, 3 do
		local var_4_4 = arg_4_0:getUserDataTb_()

		var_4_4.go = gohelper.findChild(arg_4_0._goranklights, "light" .. iter_4_3)
		var_4_4.lights = arg_4_0:getUserDataTb_()

		for iter_4_4 = 1, iter_4_3 do
			table.insert(var_4_4.lights, gohelper.findChild(var_4_4.go, "star" .. iter_4_4))
		end

		arg_4_0._ranklights[iter_4_3] = var_4_4
	end

	arg_4_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goskill, CharacterSkillContainer)
	arg_4_0._passiveskillitems = {}

	for iter_4_5 = 1, 3 do
		arg_4_0._passiveskillitems[iter_4_5] = arg_4_0:_findPassiveskillitems(iter_4_5)
	end

	arg_4_0._passiveskillitems[0] = arg_4_0:_findPassiveskillitems(4)
	arg_4_0._exskills = arg_4_0:getUserDataTb_()

	for iter_4_6 = 1, 5 do
		arg_4_0._exskills[iter_4_6] = gohelper.findChild(arg_4_0._goexskills, "exskill" .. tostring(iter_4_6))
	end

	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._goherocontainer)
	arg_4_0._signatureDrag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._simagesignature.gameObject)
	arg_4_0._trustclick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._txttrust.gameObject)
	arg_4_0._careerclick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._imagecareericon.gameObject)
	arg_4_0._signatureClick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._simagesignature.gameObject)
	arg_4_0._enableSwitchDrawing = false
	arg_4_0._gopifu = gohelper.findChild(arg_4_0.viewGO, "anim/bottom/#pifu")

	gohelper.setActive(arg_4_0._gopifu, arg_4_0._enableSwitchDrawing)
	arg_4_0:_addListener()

	arg_4_0._originSpineRootPosX = recthelper.getAnchorX(arg_4_0._goherocontainer.transform)
	arg_4_0._animator = ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._herocontainerCanvasGroup = arg_4_0._goherocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._hasMoveIcon = false

	gohelper.setActive(arg_4_0._goattributenode, true)
	arg_4_0._animatorattributetipsnode:Play("close", 0, 1)

	arg_4_0._talentRedType1 = gohelper.findChild(arg_4_0._gotalentreddot, "type1")
	arg_4_0._talentRedNew = gohelper.findChild(arg_4_0._gotalentreddot, "new")
end

function var_0_0._findPassiveskillitems(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getUserDataTb_()

	var_5_0.go = gohelper.findChild(arg_5_0._gopassiveskills, "passiveskill" .. arg_5_1)
	var_5_0.on = gohelper.findChild(var_5_0.go, "on")
	var_5_0.off = gohelper.findChild(var_5_0.go, "off")

	return var_5_0
end

function var_0_0._refreshHelp(arg_6_0)
	local var_6_0 = arg_6_0._heroMO and arg_6_0:isOwnHero()
	local var_6_1 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(arg_6_0._btnhelp.gameObject, var_6_1 and var_6_0)
end

function var_0_0._takeoffAllTalentCube(arg_7_0)
	HeroRpc.instance:TakeoffAllTalentCubeRequest(arg_7_0._heroMO.heroId)
end

function var_0_0._addDrag(arg_8_0)
	if not arg_8_0._drag then
		return
	end

	arg_8_0._drag:AddDragBeginListener(arg_8_0._onDragBegin, arg_8_0)
	arg_8_0._drag:AddDragListener(arg_8_0._onDrag, arg_8_0)
	arg_8_0._drag:AddDragEndListener(arg_8_0._onDragEnd, arg_8_0)
	arg_8_0._signatureDrag:AddDragBeginListener(arg_8_0._onDragBegin, arg_8_0)
	arg_8_0._signatureDrag:AddDragListener(arg_8_0._onDrag, arg_8_0)
	arg_8_0._signatureDrag:AddDragEndListener(arg_8_0._onDragEnd, arg_8_0)
end

function var_0_0._addListener(arg_9_0)
	arg_9_0._trustclick:AddClickListener(arg_9_0._onOpenTrustTip, arg_9_0)
	arg_9_0._careerclick:AddClickListener(arg_9_0._onOpenCareerTip, arg_9_0)
	arg_9_0._signatureClick:AddClickListener(arg_9_0._switchDrawingOnClick, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.TakeoffAllTalentCube, arg_9_0._takeoffAllTalentCube, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_9_0._refreshView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_9_0._refreshView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_9_0._refreshView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_9_0._refreshView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_9_0._successDressUpSkin, arg_9_0)
	arg_9_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_9_0._refreshRedDot, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_9_0._onAttributeChanged, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_9_0._onAttributeChanged, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_9_0._showCharacterRankUpView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_9_0._markFavorSuccess, arg_9_0)
	arg_9_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_9_0._refreshHelp, arg_9_0)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_9_0._onOpenFullView, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_9_0._onOpenFullViewFinish, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_9_0._onOpenView, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_9_0._onOpenViewFinish, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_9_0._onCloseViewFinish, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_9_0._onCloseFullView, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_9_0._onCloseView, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_9_0.onEquipChange, arg_9_0)
	arg_9_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_9_0.onEquipChange, arg_9_0)
end

function var_0_0._markFavorSuccess(arg_10_0)
	arg_10_0._heroMO = HeroModel.instance:getByHeroId(arg_10_0._heroMO.heroId)

	arg_10_0:_refreshBtn()
end

function var_0_0._onApplicationPause(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0:_resetSpinePos(false)
	end
end

function var_0_0._setModelVisible(arg_12_0, arg_12_1)
	TaskDispatcher.cancelTask(arg_12_0._delaySetModelHide, arg_12_0)

	if not arg_12_0:isSpineInView() then
		return
	end

	if arg_12_1 then
		arg_12_0._uiSpine:setLayer(UnityLayer.Unit)
		arg_12_0._uiSpine:setModelVisible(arg_12_1)
		arg_12_0._uiSpine:showModelEffect()
	else
		arg_12_0._uiSpine:setLayer(UnityLayer.Water)
		arg_12_0._uiSpine:hideModelEffect()
		TaskDispatcher.runDelay(arg_12_0._delaySetModelHide, arg_12_0, 1)
	end
end

function var_0_0._delaySetModelHide(arg_13_0)
	if not arg_13_0:isSpineInView() then
		return
	end

	if arg_13_0._uiSpine then
		arg_13_0._uiSpine:setModelVisible(false)
	end
end

function var_0_0._showCharacterRankUpView(arg_14_0, arg_14_1)
	if not arg_14_0._uiSpine then
		return
	end

	arg_14_0:_setModelVisible(false)

	if arg_14_1 then
		arg_14_0:playCloseViewAnim(arg_14_1)
	end
end

function var_0_0._onOpenView(arg_15_0, arg_15_1)
	return
end

function var_0_0._onOpenViewFinish(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.CharacterRankUpResultView and arg_16_0._uiSpine then
		arg_16_0._uiSpine:hideModelEffect()
	end

	if arg_16_1 == ViewName.CharacterRecommedView then
		arg_16_0:playAnim(UIAnimationName.Open)
	end

	if arg_16_1 ~= ViewName.CharacterGetView then
		return
	end

	if arg_16_0._uiSpine then
		arg_16_0:_setModelVisible(false)
	end
end

function var_0_0._successDressUpSkin(arg_17_0)
	arg_17_0.needSwitchSkin = true
end

function var_0_0._onCloseView(arg_18_0, arg_18_1)
	if ViewHelper.instance:checkViewOnTheTop(arg_18_0.viewName) then
		arg_18_0:setShaderKeyWord()

		if arg_18_0.needSwitchSkin then
			arg_18_0:_refreshSkin()

			arg_18_0.needSwitchSkin = false
		end
	end

	if arg_18_1 == ViewName.CharacterLevelUpView then
		gohelper.setActive(arg_18_0._goattributenode, true)
		arg_18_0._animatorattributetipsnode:Play("close", 0, 0)
	end

	if arg_18_1 == ViewName.CharacterRecommedView then
		arg_18_0:_refreshSkin()
	end
end

function var_0_0._onCloseViewFinish(arg_19_0, arg_19_1)
	if ViewHelper.instance:checkViewOnTheTop(arg_19_0.viewName) then
		arg_19_0:setShaderKeyWord()
	end

	if arg_19_1 == ViewName.CharacterRankUpResultView and arg_19_0._uiSpine then
		arg_19_0._uiSpine:showModelEffect()
	end

	if arg_19_1 ~= ViewName.CharacterGetView then
		return
	end

	if not arg_19_0._uiSpine then
		return
	end

	arg_19_0:_setModelVisible(true)
end

function var_0_0._onOpenFullView(arg_20_0, arg_20_1)
	if not arg_20_0._uiSpine or arg_20_1 == ViewName.CharacterView or arg_20_1 == ViewName.CharacterRecommedView then
		return
	end

	arg_20_0:_setModelVisible(false)
end

function var_0_0._onOpenFullViewFinish(arg_21_0, arg_21_1)
	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not arg_21_0._uiSpine or arg_21_1 == ViewName.CharacterView or arg_21_1 == ViewName.CharacterRecommedView then
		return
	end

	if arg_21_1 ~= ViewName.CharacterView then
		arg_21_0._uiSpine:stopVoice()
	else
		return
	end

	arg_21_0:_setModelVisible(arg_21_0.viewContainer._isVisible)
end

function var_0_0._onCloseFullView(arg_22_0, arg_22_1)
	if arg_22_0._animator and arg_22_0:isEnterCharacterView() then
		arg_22_0:playAnim(UIAnimationName.Open)
		arg_22_0.viewContainer:getEquipView():playOpenAnim()
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not arg_22_0._uiSpine then
		return
	end

	arg_22_0:_setModelVisible(arg_22_0.viewContainer._isVisible)

	if arg_22_1 == ViewName.CharacterRankUpResultView then
		arg_22_0:_checkPlaySpecialBodyMotion()

		if arg_22_0._skillContainer then
			arg_22_0._skillContainer:checkShowReplaceBeforeSkillUI()
		end
	end

	arg_22_0:_checkGuide()
end

function var_0_0.isSpineInView(arg_23_0)
	return gohelper.findChild(arg_23_0.viewGO, "anim/#go_herocontainer/dynamiccontainer")
end

function var_0_0.isEnterCharacterView(arg_24_0)
	local var_24_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_24_0 = #var_24_0, 1, -1 do
		if ViewMgr.instance:getSetting(var_24_0[iter_24_0]).layer == ViewMgr.instance:getSetting(arg_24_0.viewName).layer then
			return var_24_0[iter_24_0] == arg_24_0.viewName
		end
	end

	return false
end

function var_0_0.onOpenFinish(arg_25_0)
	arg_25_0:_addDrag()

	arg_25_0._isOpenFinish = true

	if arg_25_0._spineLoadedFinish then
		arg_25_0:_onSpineLoaded()
	end

	if not GuideModel.instance:isGuideRunning(GuideEnum.VerticalDrawingSwitchingGuide) or not arg_25_0._showSwitchDrawingGuide then
		local var_25_0 = arg_25_0.viewContainer.helpShowView

		var_25_0:setHelpId(HelpEnum.HelpId.Character)
		var_25_0:setDelayTime(0.5)
		var_25_0:tryShowHelp()
	end
end

function var_0_0._onOpenTrustTip(arg_26_0)
	logNormal("打开信赖值tip, 达到下一百分比羁绊值需要 " .. arg_26_0.nextFaith .. " 的羁绊值")
end

function var_0_0._onOpenCareerTip(arg_27_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_switch)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._closeLevelUpview(arg_28_0)
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	end
end

function var_0_0._btncloseOnClick(arg_29_0)
	arg_29_0:_closeLevelUpview()
	arg_29_0:closeThis()
end

function var_0_0._btnhomeOnClick(arg_30_0)
	arg_30_0:_closeLevelUpview()
	NavigateButtonsView.homeClick()
end

function var_0_0._btndataOnClick(arg_31_0)
	arg_31_0:_closeLevelUpview()

	local function var_31_0()
		CharacterController.instance:openCharacterDataView(arg_31_0._heroMO.heroId)
	end

	arg_31_0:playCloseViewAnim(var_31_0)
end

function var_0_0._btnskinOnClick(arg_33_0)
	arg_33_0:_closeLevelUpview()

	if arg_33_0._uiSpine then
		arg_33_0:_setModelVisible(false)
	end

	local function var_33_0()
		CharacterController.instance:openCharacterSkinView(arg_33_0._heroMO)
	end

	arg_33_0:playCloseViewAnim(var_33_0)
end

function var_0_0._btnfavorOnClick(arg_35_0)
	local var_35_0 = not arg_35_0._heroMO.isFavor

	if var_35_0 and #HeroModel.instance:getAllFavorHeros() >= CommonConfig.instance:getConstNum(ConstEnum.MaxFavorHeroCount) then
		GameFacade.showToast(ToastEnum.OverFavorMaxCount)

		return
	end

	local var_35_1 = arg_35_0._heroMO.heroId

	HeroRpc.instance:setMarkHeroFavorRequest(var_35_1, var_35_0)
end

function var_0_0._btnhelpOnClick(arg_36_0)
	arg_36_0:_closeLevelUpview()
	HelpController.instance:showHelp(HelpEnum.HelpId.Character)
end

function var_0_0._btnrecommedOnClick(arg_37_0)
	local function var_37_0()
		CharacterRecommedController.instance:openRecommedView(arg_37_0._heroMO.heroId, arg_37_0.viewName, arg_37_0._uiSpine)
	end

	arg_37_0:playCloseViewAnim(var_37_0)
end

function var_0_0._btnattributeOnClick(arg_39_0)
	local var_39_0 = {}

	var_39_0.tag = "attribute"
	var_39_0.heroMo = arg_39_0._heroMO
	var_39_0.heroid = arg_39_0._heroMO.heroId
	var_39_0.equips = arg_39_0._heroMO.defaultEquipUid ~= "0" and {
		arg_39_0._heroMO.defaultEquipUid
	} or nil
	var_39_0.trialEquipMo = arg_39_0._heroMO.trialEquipMo

	CharacterController.instance:openCharacterTipView(var_39_0)
end

function var_0_0._btnlevelOnClick(arg_40_0)
	CharacterController.instance:openCharacterLevelUpView(arg_40_0._heroMO, ViewName.CharacterView)
	arg_40_0._animatorattributetipsnode:Play("open", 0, 0)
	gohelper.setActive(arg_40_0._goattributenode, false)
end

function var_0_0._btnrankOnClick(arg_41_0)
	if not arg_41_0._uiSpine then
		return
	end

	arg_41_0:_setModelVisible(false)

	local function var_41_0()
		CharacterController.instance:openCharacterRankUpView(arg_41_0._heroMO)
	end

	arg_41_0:playCloseViewAnim(var_41_0)
end

function var_0_0._btnpassiveskillOnClick(arg_43_0)
	local var_43_0 = {}

	var_43_0.tag = "passiveskill"
	var_43_0.heroid = arg_43_0._heroMO.heroId
	var_43_0.anchorParams = {
		Vector2.New(1, 0.5),
		Vector2.New(1, 0.5)
	}
	var_43_0.tipPos = Vector2.New(-292, -51.1)
	var_43_0.buffTipsX = -770
	var_43_0.heroMo = arg_43_0._heroMO

	CharacterController.instance:openCharacterTipView(var_43_0)
end

function var_0_0._btnexskillOnClick(arg_44_0)
	if arg_44_0._heroMO and arg_44_0._heroMO:isNoShowExSkill() then
		GameFacade.showToast(ToastEnum.TrialHeroClickExSkill)

		return
	end

	local function var_44_0()
		CharacterController.instance:openCharacterExSkillView({
			heroId = arg_44_0._heroMO.heroId,
			heroMo = arg_44_0._heroMO,
			fromHeroDetailView = arg_44_0._fromHeroDetailView,
			hideTrialTip = arg_44_0._hideTrialTip
		})
	end

	arg_44_0:playCloseViewAnim(var_44_0)
end

function var_0_0._btntalentOnClick(arg_46_0)
	local var_46_0 = arg_46_0._heroMO:isOtherPlayerHero()

	if var_46_0 and not arg_46_0._heroMO:getOtherPlayerIsOpenTalent() then
		GameFacade.showToast(ToastEnum.TalentNotUnlock)

		return
	end

	local var_46_1 = arg_46_0._heroMO:isTrial()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or var_46_1 or var_46_0 then
		if arg_46_0._heroMO.rank < CharacterEnum.TalentRank then
			if arg_46_0._heroMO.config.heroType == CharacterEnum.HumanHeroType then
				GameFacade.showToast(ToastEnum.CharacterType6, arg_46_0._heroMO.config.name)
			else
				GameFacade.showToast(ToastEnum.Character, arg_46_0._heroMO.config.name)
			end

			return
		end

		local var_46_2 = arg_46_0:isOwnHero()

		if not var_46_2 then
			CharacterController.instance:openCharacterTalentTipView({
				open_type = 0,
				isTrial = true,
				hero_id = arg_46_0._heroMO.heroId,
				hero_mo = arg_46_0._heroMO,
				isOwnHero = var_46_2
			})

			return
		end

		CharacterController.instance:setTalentHeroId(arg_46_0._heroMO.heroId)

		local function var_46_3()
			CharacterController.instance:openCharacterTalentView({
				heroid = arg_46_0._heroMO.heroId,
				heroMo = arg_46_0._heroMO
			})
		end

		arg_46_0:playCloseViewAnim(var_46_3)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Talent))
	end
end

function var_0_0._switchDrawingOnClick(arg_48_0)
	if not arg_48_0._enableSwitchDrawing or arg_48_0._isDragingSpine then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_48_0 = SkinConfig.instance:getSkinCo(arg_48_0._heroMO.skin)
	local var_48_1 = CharacterDataConfig.instance:getCharacterDrawingState(var_48_0.characterId)

	if var_48_1 == CharacterEnum.DrawingState.Static then
		var_48_1 = CharacterEnum.DrawingState.Dynamic
	else
		var_48_1 = CharacterEnum.DrawingState.Static
	end

	CharacterDataConfig.instance:setCharacterDrawingState(var_48_0.characterId, var_48_1)
	arg_48_0:_refreshDrawingState()
end

function var_0_0._initExternalParams(arg_49_0)
	local var_49_0 = var_0_0._externalParam

	arg_49_0._hideHomeBtn = var_49_0 and var_49_0.hideHomeBtn
	arg_49_0._isOwnHero = var_49_0 and var_49_0.isOwnHero
	arg_49_0._fromHeroDetailView = var_49_0 and var_49_0.fromHeroDetailView
	arg_49_0._hideTrialTip = var_49_0 and var_49_0.hideTrialTip

	arg_49_0.viewContainer:setIsOwnHero(var_49_0)

	var_0_0._externalParam = nil
end

function var_0_0.onOpen(arg_50_0)
	arg_50_0:_initExternalParams()

	arg_50_0._heroMO = arg_50_0.viewParam
	arg_50_0._playGreetingVoices = true
	arg_50_0._spineNeedHide = true

	arg_50_0:_refreshView()
	NavigateMgr.instance:addEscape(ViewName.CharacterView, arg_50_0._btncloseOnClick, arg_50_0)
	arg_50_0:_checkGuide()
	arg_50_0:_refreshCharacter()
end

function var_0_0._refreshCharacter(arg_51_0)
	if arg_51_0._skillContainer then
		arg_51_0._skillContainer:checkShowReplaceBeforeSkillUI()
	end

	arg_51_0:_refreshRecommedBtn()
end

function var_0_0._refreshRecommedBtn(arg_52_0)
	local var_52_0 = false

	if ViewMgr.instance:isOpen(ViewName.CharacterBackpackView) then
		var_52_0 = CharacterRecommedModel.instance:isShowRecommedView(arg_52_0._heroMO.heroId)
	end

	gohelper.setActive(arg_52_0._btnrecommed.gameObject, var_52_0)
end

function var_0_0._refreshRedDot(arg_53_0)
	if not arg_53_0:isOwnHero() then
		gohelper.setActive(arg_53_0._goexskillreddot, false)
		gohelper.setActive(arg_53_0._gorankreddot, false)
		gohelper.setActive(arg_53_0._godatareddot, false)
		arg_53_0:_showRedDot(false)

		return
	end

	local var_53_0 = CharacterModel.instance:isHeroCouldExskillUp(arg_53_0._heroMO.heroId)

	gohelper.setActive(arg_53_0._goexskillreddot, var_53_0)

	local var_53_1 = CharacterModel.instance:isHeroCouldRankUp(arg_53_0._heroMO.heroId)

	gohelper.setActive(arg_53_0._gorankreddot, var_53_1)

	local var_53_2 = CharacterModel.instance:hasCultureRewardGet(arg_53_0._heroMO.heroId) or CharacterModel.instance:hasItemRewardGet(arg_53_0._heroMO.heroId)

	gohelper.setActive(arg_53_0._godatareddot, var_53_2)
	arg_53_0:_refreshTalentRed()
end

function var_0_0._showRedDot(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_1 then
		gohelper.setActive(arg_54_0._gotalentreddot, true)
		gohelper.setActive(arg_54_0._talentRedType1, arg_54_2 == 1)
		gohelper.setActive(arg_54_0._talentRedNew, arg_54_2 == 2)
	else
		gohelper.setActive(arg_54_0._gotalentreddot, false)
	end
end

function var_0_0._refreshTalentRed(arg_55_0)
	local var_55_0 = CharacterModel.instance:heroTalentRedPoint(arg_55_0._heroMO.heroId)
	local var_55_1 = arg_55_0._heroMO.isShowTalentStyleRed and 2 or var_55_0 and 1 or 0

	arg_55_0:_showRedDot(true, var_55_1)
end

function var_0_0._refreshView(arg_56_0)
	arg_56_0:_unmarkNew()
	arg_56_0:_refreshBtn()
	arg_56_0:_refreshSkill()
	arg_56_0:_refreshDrawingState()
	arg_56_0:_refreshSpine()
	arg_56_0:_refreshInfo()
	arg_56_0:_refreshCareer()
	arg_56_0:_refreshAttribute()
	arg_56_0:_refreshLevel()
	arg_56_0:_refreshRank()
	arg_56_0:_refreshPassiveSkill()
	arg_56_0:_refreshExSkill()
	arg_56_0:_refreshTalent()
	arg_56_0:_refreshSignature()
	arg_56_0:_refreshRedDot()
end

function var_0_0.isOwnHero(arg_57_0)
	if arg_57_0._isOwnHero ~= nil then
		return arg_57_0._isOwnHero
	end

	return arg_57_0._heroMO and arg_57_0._heroMO:isOwnHero()
end

function var_0_0._refreshBtn(arg_58_0)
	local var_58_0 = arg_58_0:isOwnHero()
	local var_58_1 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(arg_58_0._btnhome.gameObject, not arg_58_0._hideHomeBtn)
	gohelper.setActive(arg_58_0._btnhelp.gameObject, var_58_1 and var_58_0)
	gohelper.setActive(arg_58_0._btnskin.gameObject, CharacterEnum.SkinOpen and var_58_0)
	gohelper.setActive(arg_58_0._btnfavor.gameObject, var_58_0)
	gohelper.setActive(arg_58_0._btndata.gameObject, var_58_0)
	gohelper.setActive(arg_58_0._btnlevel.gameObject, var_58_0)
	gohelper.setActive(arg_58_0._btnrank.gameObject, var_58_0)
	gohelper.setActive(arg_58_0._golevelimage, var_58_0)
	gohelper.setActive(arg_58_0._golevelicon.gameObject, var_58_0)
	gohelper.setActive(arg_58_0._gorankicon, var_58_0)
	gohelper.setActive(arg_58_0._gorankimage, var_58_0)
	gohelper.setActive(arg_58_0._golevelimagetrial, not var_58_0)
	gohelper.setActive(arg_58_0._gorankimagetrial, not var_58_0)

	if not var_58_0 and not arg_58_0._hasMoveIcon then
		recthelper.setAnchorX(arg_58_0._gorankeyes.transform, recthelper.getAnchorX(arg_58_0._gorankeyes.transform) + var_0_0.RankIconOffset)
		recthelper.setAnchorX(arg_58_0._goranklights.transform, recthelper.getAnchorX(arg_58_0._goranklights.transform) + var_0_0.RankIconOffset)

		arg_58_0._hasMoveIcon = true
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_58_0._imagefavor, arg_58_0._heroMO.isFavor and "btn_favor_light" or "btn_favor_dark")
end

function var_0_0._refreshSkin(arg_59_0)
	arg_59_0._spineNeedHide = true

	arg_59_0:_refreshDrawingState()
	arg_59_0:_refreshSpine()
end

function var_0_0._unmarkNew(arg_60_0)
	if arg_60_0._heroMO and arg_60_0._heroMO.isNew then
		HeroRpc.instance:sendUnMarkIsNewRequest(arg_60_0._heroMO.heroId)
	end
end

function var_0_0._onDragBegin(arg_61_0, arg_61_1, arg_61_2)
	arg_61_0._startPos = arg_61_2.position.x

	arg_61_0:playAnim(UIAnimationName.SwitchClose)

	arg_61_0._isDragingSpine = true

	if arg_61_0._uiSpine then
		arg_61_0._uiSpine:showDragEffect(false)
	end
end

function var_0_0._onDrag(arg_62_0, arg_62_1, arg_62_2)
	if not arg_62_0._isDragingSpine then
		return
	end

	local var_62_0 = arg_62_2.position.x
	local var_62_1 = 1
	local var_62_2 = recthelper.getAnchorX(arg_62_0._goherocontainer.transform) + arg_62_2.delta.x * var_62_1

	recthelper.setAnchorX(arg_62_0._goherocontainer.transform, var_62_2)

	local var_62_3 = 0.001

	arg_62_0._herocontainerCanvasGroup.alpha = 1 - Mathf.Abs(arg_62_0._startPos - var_62_0) * var_62_3
end

function var_0_0._onDragEnd(arg_63_0, arg_63_1, arg_63_2)
	if not arg_63_0._isDragingSpine then
		return
	end

	if arg_63_0._uiSpine then
		arg_63_0._uiSpine:showDragEffect(true)
	end

	local var_63_0 = arg_63_2.position.x
	local var_63_1 = false
	local var_63_2 = false

	if var_63_0 > arg_63_0._startPos and var_63_0 - arg_63_0._startPos >= 300 then
		local var_63_3 = CharacterBackpackCardListModel.instance:getLastCharacterCard(arg_63_0._heroMO.heroId)

		if var_63_3 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

			arg_63_0._heroMO = var_63_3
			arg_63_0.viewContainer.viewParam = arg_63_0._heroMO
			arg_63_0._playGreetingVoices = true
			arg_63_0._delayPlayVoiceTime = 0.3
			var_63_2 = true
			arg_63_0._spineNeedHide = true

			arg_63_0:_refreshView()
			arg_63_0:_refreshCharacter()
			CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, arg_63_0._heroMO)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, arg_63_0._heroMO)
		end
	elseif var_63_0 < arg_63_0._startPos and arg_63_0._startPos - var_63_0 >= 300 then
		local var_63_4 = CharacterBackpackCardListModel.instance:getNextCharacterCard(arg_63_0._heroMO.heroId)

		if var_63_4 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

			arg_63_0._heroMO = var_63_4
			arg_63_0.viewContainer.viewParam = arg_63_0._heroMO
			arg_63_0._playGreetingVoices = true
			arg_63_0._delayPlayVoiceTime = 0.3
			var_63_2 = true
			arg_63_0._spineNeedHide = true

			arg_63_0:_refreshView()
			arg_63_0:_refreshCharacter()
			CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, arg_63_0._heroMO)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, arg_63_0._heroMO)

			var_63_1 = true
		end
	end

	arg_63_0:_resetSpinePos(var_63_2, var_63_1)

	arg_63_0._isDragingSpine = false
end

function var_0_0._cutCharacter(arg_64_0, arg_64_1)
	arg_64_0._heroMO = HeroModel.instance:getByHeroId(arg_64_1)
	arg_64_0.viewContainer.viewParam = arg_64_0._heroMO
	arg_64_0._playGreetingVoices = true
	arg_64_0._delayPlayVoiceTime = 0.3
	arg_64_0._spineNeedHide = true

	arg_64_0:_refreshView()
	arg_64_0:_refreshCharacter()
	CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, arg_64_0._heroMO)
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, arg_64_0._heroMO)
end

function var_0_0._resetSpinePos(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = recthelper.getAnchorX(arg_65_0._goherocontainer.transform)
	local var_65_1 = -800
	local var_65_2 = 800
	local var_65_3 = var_65_0

	if arg_65_1 then
		local var_65_4 = arg_65_2 and var_65_1 or var_65_2

		recthelper.setAnchorX(arg_65_0._goherocontainer.transform, var_65_4)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_65_0._goherocontainer.transform)

	local var_65_5 = 0.3
	local var_65_6 = 0.5
	local var_65_7 = arg_65_1 and var_65_6 or var_65_5

	if arg_65_0._dragTweenId then
		ZProj.TweenHelper.KillById(arg_65_0._dragTweenId)
	end

	arg_65_0._dragTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_65_0._goherocontainer.transform, arg_65_0._originSpineRootPosX, var_65_7, nil, arg_65_0, nil, EaseType.OutQuart)

	arg_65_0:playAnim(UIAnimationName.SwitchOpen)
	arg_65_0.viewContainer:getEquipView():playOpenAnim()

	arg_65_0._herocontainerCanvasGroup.alpha = 1
end

function var_0_0._refreshSignature(arg_66_0)
	local var_66_0 = arg_66_0._heroMO.config

	arg_66_0._simagesignature:UnLoadImage()
	arg_66_0._simagesignature:LoadImage(ResUrl.getSignature(var_66_0.signature))
end

function var_0_0._refreshSpine(arg_67_0)
	if not arg_67_0:isSpineInView() then
		if arg_67_0._uiSpine then
			TaskDispatcher.cancelTask(arg_67_0._playSpineVoice, arg_67_0)
			arg_67_0._uiSpine:stopVoice()
		end

		return
	end

	if arg_67_0._uiSpine then
		TaskDispatcher.cancelTask(arg_67_0._playSpineVoice, arg_67_0)
		arg_67_0._uiSpine:onDestroy()
		arg_67_0._uiSpine:stopVoice()

		arg_67_0._uiSpine = nil
	end

	arg_67_0._uiSpine = GuiModelAgent.Create(arg_67_0._gospine, true)

	local var_67_0 = SkinConfig.instance:getSkinCo(arg_67_0._heroMO.skin)

	arg_67_0._uiSpine:setResPath(var_67_0, arg_67_0._onSpineLoaded, arg_67_0)

	local var_67_1 = SkinConfig.instance:getSkinOffset(var_67_0.characterViewOffset)

	recthelper.setAnchor(arg_67_0._gospine.transform, tonumber(var_67_1[1]), tonumber(var_67_1[2]))
	transformhelper.setLocalScale(arg_67_0._gospine.transform, tonumber(var_67_1[3]), tonumber(var_67_1[3]), tonumber(var_67_1[3]))

	local var_67_2 = SkinConfig.instance:getSkinOffset(var_67_0.haloOffset)
	local var_67_3 = tonumber(var_67_2[1])
	local var_67_4 = tonumber(var_67_2[2])
	local var_67_5 = tonumber(var_67_2[3])

	recthelper.setAnchor(arg_67_0._simageplayerbg.transform, var_67_3, var_67_4)
	transformhelper.setLocalScale(arg_67_0._simageplayerbg.transform, var_67_5, var_67_5, var_67_5)
end

function var_0_0._onSpineLoaded(arg_68_0)
	if arg_68_0._uiSpine then
		arg_68_0._uiSpine:initSkinDragEffect(arg_68_0._heroMO.skin)
	end

	arg_68_0._spineLoadedFinish = true

	if not arg_68_0._isOpenFinish then
		return
	end

	if not arg_68_0._playGreetingVoices then
		return
	end

	if not arg_68_0._uiSpine then
		return
	end

	if not arg_68_0._gospine.activeInHierarchy then
		return
	end

	arg_68_0._playGreetingVoices = nil

	local var_68_0 = arg_68_0._heroMO.heroId
	local var_68_1 = CharacterDataConfig.instance:getCharacterDrawingState(var_68_0)

	if ViewMgr.instance:isOpen(ViewName.CharacterRankUpView) then
		return
	end

	if var_68_1 == CharacterEnum.DrawingState.Dynamic then
		if arg_68_0:isOwnHero() then
			arg_68_0._greetingVoices = HeroModel.instance:getVoiceConfig(var_68_0, CharacterEnum.VoiceType.Greeting)
		else
			arg_68_0._greetingVoices = {}

			local var_68_2 = CharacterDataConfig.instance:getCharacterVoicesCo(var_68_0)

			if var_68_2 then
				for iter_68_0, iter_68_1 in pairs(var_68_2) do
					if iter_68_1.type == CharacterEnum.VoiceType.Greeting and CharacterDataConfig.instance:checkVoiceSkin(iter_68_1, arg_68_0._heroMO.skin) then
						table.insert(arg_68_0._greetingVoices, iter_68_1)
					end
				end
			end
		end

		if arg_68_0._greetingVoices and #arg_68_0._greetingVoices > 0 then
			arg_68_0._delayTime = arg_68_0._delayPlayVoiceTime or 0

			if arg_68_0._uiSpine:isLive2D() then
				arg_68_0._uiSpine:setLive2dCameraLoadFinishCallback(arg_68_0.onLive2dCameraLoadedCallback, arg_68_0)

				return
			end

			arg_68_0:_startDelayPlayVoice(arg_68_0._delayTime)

			arg_68_0._delayPlayVoiceTime = 0
		end
	end
end

function var_0_0.onLive2dCameraLoadedCallback(arg_69_0)
	arg_69_0._uiSpine:setLive2dCameraLoadFinishCallback(nil, nil)
	arg_69_0:_startDelayPlayVoice(arg_69_0._delayTime)
end

function var_0_0._startDelayPlayVoice(arg_70_0, arg_70_1)
	arg_70_1 = arg_70_1 or 0
	arg_70_0._repeatNum = math.max(arg_70_1 * 30, CharacterVoiceEnum.DelayFrame + 1)
	arg_70_0._repeatCount = 0

	TaskDispatcher.cancelTask(arg_70_0._playSpineVoice, arg_70_0)
	TaskDispatcher.runRepeat(arg_70_0._playSpineVoice, arg_70_0, 0, arg_70_0._repeatNum)
end

function var_0_0._playSpineVoice(arg_71_0)
	if not arg_71_0:isSpineInView() then
		return
	end

	arg_71_0._repeatCount = arg_71_0._repeatCount + 1

	if arg_71_0._repeatCount < arg_71_0._repeatNum then
		return
	end

	if not arg_71_0._uiSpine then
		return
	end

	if arg_71_0:_checkPlaySpecialBodyMotion() then
		return
	end

	arg_71_0._uiSpine:playVoice(arg_71_0._greetingVoices[1], nil, arg_71_0._txtanacn, arg_71_0._txtanaen, arg_71_0._gocontentbg)
end

function var_0_0._refreshDrawingState(arg_72_0)
	if not arg_72_0:isSpineInView() then
		return
	end

	local var_72_0 = false
	local var_72_1 = SkinConfig.instance:getSkinCo(arg_72_0._heroMO.skin)

	if var_72_1.showDrawingSwitch == 1 then
		arg_72_0._enableSwitchDrawing = true

		if CharacterDataConfig.instance:getCharacterDrawingState(var_72_1.characterId) == CharacterEnum.DrawingState.Static then
			var_72_0 = true
		end
	else
		arg_72_0._enableSwitchDrawing = false

		CharacterDataConfig.instance:setCharacterDrawingState(var_72_1.characterId, CharacterEnum.DrawingState.Dynamic)
	end

	if arg_72_0._heroMO.isSettingSkinOffset then
		var_72_0 = true
	end

	if arg_72_0._spineNeedHide and var_72_0 then
		gohelper.setActive(arg_72_0._godynamiccontainer, false)
	else
		gohelper.setActive(arg_72_0._godynamiccontainer, true)
	end

	arg_72_0._spineNeedHide = false

	local var_72_2 = var_72_0 and 0.01 or 1

	transformhelper.setLocalScale(arg_72_0._godynamiccontainer.transform, var_72_2, var_72_2, var_72_2)

	if not var_72_0 then
		arg_72_0._uiSpine:hideModelEffect()
		arg_72_0._uiSpine:showModelEffect()
	end

	gohelper.setActive(arg_72_0._gostaticcontainer, var_72_0)

	if var_72_0 then
		arg_72_0._playGreetingVoices = nil

		if arg_72_0._uiSpine then
			arg_72_0._uiSpine:stopVoice()
		end

		arg_72_0._simagestatic:LoadImage(ResUrl.getHeadIconImg(var_72_1.drawing), arg_72_0._loadedImage, arg_72_0)
	else
		arg_72_0._simagestatic:UnLoadImage()
		arg_72_0:_setModelVisible(true)
	end

	gohelper.setActive(arg_72_0._gopifu, arg_72_0._enableSwitchDrawing)
end

function var_0_0._checkGuide(arg_73_0)
	arg_73_0._showSwitchDrawingGuide = false

	if not arg_73_0._enableSwitchDrawing then
		return
	end

	if not arg_73_0.viewContainer._isVisible then
		return
	end

	local var_73_0 = false
	local var_73_1 = HeroModel.instance:getList()

	for iter_73_0, iter_73_1 in ipairs(var_73_1) do
		if iter_73_1.rank > 1 and iter_73_1.config.rare >= 3 then
			var_73_0 = true

			break
		end
	end

	if var_73_0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideSwitchDrawing)
	end

	arg_73_0._showSwitchDrawingGuide = var_73_0
end

function var_0_0._loadedImage(arg_74_0)
	if not arg_74_0:isSpineInView() then
		return
	end

	local var_74_0 = SkinConfig.instance:getSkinCo(arg_74_0._heroMO.skin)

	gohelper.onceAddComponent(arg_74_0._simagestatic.gameObject, gohelper.Type_Image):SetNativeSize()

	local var_74_1 = var_74_0.characterViewImgOffset

	if not string.nilorempty(var_74_1) then
		local var_74_2 = string.splitToNumber(var_74_1, "#")

		recthelper.setAnchor(arg_74_0._simagestatic.transform, tonumber(var_74_2[1]), tonumber(var_74_2[2]))
		transformhelper.setLocalScale(arg_74_0._simagestatic.transform, tonumber(var_74_2[3]), tonumber(var_74_2[3]), tonumber(var_74_2[3]))
	else
		recthelper.setAnchor(arg_74_0._simagestatic.transform, 0, 0)
		transformhelper.setLocalScale(arg_74_0._simagestatic.transform, 1, 1, 1)
	end
end

function var_0_0._refreshInfo(arg_75_0)
	for iter_75_0 = 1, 6 do
		gohelper.setActive(arg_75_0._rareStars[iter_75_0], iter_75_0 <= CharacterEnum.Star[arg_75_0._heroMO.config.rare])
	end

	UISpriteSetMgr.instance:setCharactergetSprite(arg_75_0._imagecareericon, "charactercareer" .. tostring(arg_75_0._heroMO.config.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_75_0._imagedmgtype, "dmgtype" .. tostring(arg_75_0._heroMO.config.dmgType))

	local var_75_0 = arg_75_0:_getFaithPercent()

	arg_75_0._txttrust.text = var_75_0 * 100 .. "%"

	arg_75_0._slidertrust:SetValue(var_75_0)

	arg_75_0._txtnamecn.text = arg_75_0._heroMO:getHeroName()
	arg_75_0._txtnameen.text = arg_75_0._heroMO.config.nameEng
	arg_75_0._txttalentcn.text = luaLang("talent_character_talentcn" .. arg_75_0._heroMO:getTalentTxtByHeroType())
	arg_75_0._txttalenten.text = luaLang("talent_character_talenten" .. arg_75_0._heroMO:getTalentTxtByHeroType())
end

function var_0_0._getFaithPercent(arg_76_0)
	local var_76_0 = HeroConfig.instance:getFaithPercent(arg_76_0._heroMO.faith)

	arg_76_0.nextFaith = var_76_0[2]

	return var_76_0[1]
end

function var_0_0._refreshCareer(arg_77_0)
	local var_77_0 = arg_77_0._heroMO.config.battleTag
	local var_77_1 = {}

	if not string.nilorempty(var_77_0) then
		var_77_1 = string.split(var_77_0, "#")
	end

	for iter_77_0 = 1, 3 do
		if iter_77_0 <= #var_77_1 then
			arg_77_0._careerlabels[iter_77_0].text = HeroConfig.instance:getBattleTagConfigCO(var_77_1[iter_77_0]).tagName
		else
			arg_77_0._careerlabels[iter_77_0].text = ""
		end
	end
end

function var_0_0._onAttributeChanged(arg_78_0, arg_78_1, arg_78_2)
	if not arg_78_2 or arg_78_2 == arg_78_0._heroMO.heroId then
		arg_78_0:_refreshAttribute(arg_78_1)
	end
end

function var_0_0.onEquipChange(arg_79_0)
	if not arg_79_0.viewParam:hasDefaultEquip() then
		return
	end

	arg_79_0:_refreshAttribute()
end

function var_0_0._refreshAttribute(arg_80_0, arg_80_1)
	local var_80_0 = arg_80_0._heroMO
	local var_80_1 = var_80_0:getHeroBaseAttrDict(arg_80_1)
	local var_80_2 = HeroConfig.instance:talentGainTab2IDTab(var_80_0:getTalentGain(arg_80_1))
	local var_80_3 = var_80_0.destinyStoneMo
	local var_80_4 = var_80_3:getAddAttrValues()
	local var_80_5 = {}

	for iter_80_0, iter_80_1 in ipairs(var_0_0.AttrIdList) do
		var_80_5[iter_80_1] = 0
	end

	local var_80_6 = arg_80_0._heroMO:isOtherPlayerHero()
	local var_80_7 = arg_80_0._heroMO:hasDefaultEquip()

	if not var_80_6 and var_80_7 then
		local var_80_8 = arg_80_0._heroMO and arg_80_0._heroMO:getTrialEquipMo()

		var_80_8 = var_80_8 or EquipModel.instance:getEquip(arg_80_0._heroMO.defaultEquipUid)

		local var_80_9, var_80_10, var_80_11, var_80_12 = EquipConfig.instance:getEquipAddBaseAttr(var_80_8)

		var_80_5[CharacterEnum.AttrId.Attack] = var_80_10
		var_80_5[CharacterEnum.AttrId.Hp] = var_80_9
		var_80_5[CharacterEnum.AttrId.Defense] = var_80_11
		var_80_5[CharacterEnum.AttrId.Mdefense] = var_80_12

		local var_80_13 = EquipConfig.instance:getEquipBreakAddAttrValueDict(var_80_8.config, var_80_8.breakLv)

		for iter_80_2, iter_80_3 in ipairs(var_0_0.AttrIdList) do
			local var_80_14 = var_80_13[iter_80_3]

			if var_80_14 ~= 0 then
				var_80_5[iter_80_3] = var_80_5[iter_80_3] + math.floor(var_80_14 / 100 * var_80_1[iter_80_3])
			end
		end
	end

	for iter_80_4, iter_80_5 in ipairs(var_0_0.AttrIdList) do
		local var_80_15 = var_80_2[iter_80_5] and var_80_2[iter_80_5].value and math.floor(var_80_2[iter_80_5].value) or 0
		local var_80_16 = var_80_3 and var_80_3:getAddValueByAttrId(var_80_4, iter_80_5, var_80_0) or 0
		local var_80_17 = var_80_1[iter_80_5] + var_80_5[iter_80_5] + var_80_15 + var_80_16

		arg_80_0._attributevalues[iter_80_4].value.text = var_80_17

		local var_80_18 = HeroConfig.instance:getHeroAttributeCO(iter_80_5)

		arg_80_0._attributevalues[iter_80_4].name.text = var_80_18.name

		CharacterController.instance:SetAttriIcon(arg_80_0._attributevalues[iter_80_4].icon, iter_80_5, var_0_0.AttrIconColor)

		local var_80_19 = arg_80_0._levelUpAttributeValues[iter_80_4]

		var_80_19.value.text = var_80_17
		var_80_19.name.text = var_80_18.name

		CharacterController.instance:SetAttriIcon(var_80_19.icon, iter_80_5, var_0_0.AttrIconColor)
	end
end

function var_0_0._refreshAttributeTips(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0._heroMO
	local var_81_1 = var_81_0.level

	if not arg_81_1 or arg_81_1 < var_81_1 then
		for iter_81_0, iter_81_1 in ipairs(arg_81_0._levelUpAttributeValues) do
			iter_81_1.newValue.text = 0
		end

		return
	end

	local var_81_2 = arg_81_1 == var_81_1
	local var_81_3 = var_81_0:getHeroBaseAttrDict(arg_81_1)
	local var_81_4 = HeroConfig.instance:talentGainTab2IDTab(var_81_0:getTalentGain(arg_81_1))
	local var_81_5 = var_81_0.destinyStoneMo
	local var_81_6 = var_81_5:getAddAttrValues()
	local var_81_7 = {}

	for iter_81_2, iter_81_3 in ipairs(var_0_0.AttrIdList) do
		var_81_7[iter_81_3] = 0
	end

	if var_81_0:hasDefaultEquip() then
		local var_81_8 = EquipModel.instance:getEquip(var_81_0.defaultEquipUid)
		local var_81_9, var_81_10, var_81_11, var_81_12 = EquipConfig.instance:getEquipAddBaseAttr(var_81_8)

		var_81_7[CharacterEnum.AttrId.Attack] = var_81_10
		var_81_7[CharacterEnum.AttrId.Hp] = var_81_9
		var_81_7[CharacterEnum.AttrId.Defense] = var_81_11
		var_81_7[CharacterEnum.AttrId.Mdefense] = var_81_12

		local var_81_13 = EquipConfig.instance:getEquipBreakAddAttrValueDict(var_81_8.config, var_81_8.breakLv)

		for iter_81_4, iter_81_5 in ipairs(var_0_0.AttrIdList) do
			local var_81_14 = var_81_13[iter_81_5]

			if var_81_14 ~= 0 then
				var_81_7[iter_81_5] = var_81_7[iter_81_5] + math.floor(var_81_14 / 100 * var_81_3[iter_81_5])
			end
		end
	end

	for iter_81_6, iter_81_7 in ipairs(var_0_0.AttrIdList) do
		local var_81_15 = var_81_4[iter_81_7] and var_81_4[iter_81_7].value and math.floor(var_81_4[iter_81_7].value) or 0
		local var_81_16 = var_81_5 and var_81_5:getAddValueByAttrId(var_81_6, iter_81_7, var_81_0) or 0
		local var_81_17 = var_81_3[iter_81_7] + var_81_7[iter_81_7] + var_81_15 + var_81_16
		local var_81_18 = arg_81_0._levelUpAttributeValues[iter_81_6]
		local var_81_19 = var_81_18.newValue

		var_81_19.text = var_81_17

		local var_81_20 = var_81_2 and "#C7C3C0" or "#65B96F"

		var_81_19.color = GameUtil.parseColor(var_81_20)
		var_81_18.newValueArrow.color = GameUtil.parseColor(var_81_20)
	end
end

function var_0_0._refreshLevel(arg_82_0)
	local var_82_0 = HeroConfig.instance:getShowLevel(arg_82_0._heroMO.level)
	local var_82_1 = HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(arg_82_0._heroMO.heroId, arg_82_0._heroMO.rank)[1])
	local var_82_2 = var_82_0 .. "/"

	if arg_82_0._heroMO:getIsBalance() then
		var_82_2 = string.format("<color=#81abe5>%s</color>/", var_82_0)
	end

	arg_82_0._txtlevel.text = var_82_2
	arg_82_0._txtlevelmax.text = var_82_1
end

function var_0_0._refreshRank(arg_83_0)
	local var_83_0 = arg_83_0._heroMO.config.rare
	local var_83_1 = arg_83_0._heroMO.rank
	local var_83_2 = HeroConfig.instance:getMaxRank(var_83_0)

	for iter_83_0 = 1, 3 do
		gohelper.setActive(arg_83_0._ranklights[iter_83_0].go, var_83_2 == iter_83_0)

		for iter_83_1 = 1, iter_83_0 do
			if iter_83_1 <= var_83_1 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(arg_83_0._ranklights[iter_83_0].lights[iter_83_1]:GetComponent("Image"), "#feb73b")
			else
				SLFramework.UGUI.GuiHelper.SetColor(arg_83_0._ranklights[iter_83_0].lights[iter_83_1]:GetComponent("Image"), "#737373")
			end
		end
	end
end

function var_0_0._refreshSkill(arg_84_0)
	arg_84_0._skillContainer:onUpdateMO(arg_84_0._heroMO.heroId, nil, arg_84_0._heroMO)
end

function var_0_0._onRefreshDestiny(arg_85_0, arg_85_1, arg_85_2)
	arg_85_0:_refreshSkill()
end

function var_0_0._onJumpView(arg_86_0, arg_86_1)
	if arg_86_1 == CharacterRecommedEnum.JumpView.Level then
		local var_86_0 = CharacterRecommedModel.instance:getTracedHeroDevelopGoalsMO()

		arg_86_0:_cutCharacter(var_86_0._heroId)

		if arg_86_0._animator then
			arg_86_0:playAnim(UIAnimationName.Open)
			arg_86_0._animatorattributetipsnode:Play("open", 0, 0)
		end
	end
end

function var_0_0._refreshPassiveSkill(arg_87_0)
	local var_87_0 = arg_87_0._heroMO:getpassiveskillsCO()
	local var_87_1 = var_87_0[1].skillPassive
	local var_87_2 = lua_skill.configDict[var_87_1]

	if not var_87_2 then
		logError("找不到被动技能, skillId: " .. tostring(var_87_1))

		return
	end

	arg_87_0._txtpassivename.text = var_87_2.name

	for iter_87_0 = 1, #var_87_0 do
		local var_87_3 = CharacterModel.instance:isPassiveUnlockByHeroMo(arg_87_0._heroMO, iter_87_0)

		gohelper.setActive(arg_87_0._passiveskillitems[iter_87_0].on, var_87_3)
		gohelper.setActive(arg_87_0._passiveskillitems[iter_87_0].off, not var_87_3)
		gohelper.setActive(arg_87_0._passiveskillitems[iter_87_0].go, true)
	end

	for iter_87_1 = #var_87_0 + 1, #arg_87_0._passiveskillitems do
		gohelper.setActive(arg_87_0._passiveskillitems[iter_87_1].go, false)
	end

	if var_87_0[0] then
		gohelper.setActive(arg_87_0._passiveskillitems[0].on, true)
		gohelper.setActive(arg_87_0._passiveskillitems[0].off, false)
		gohelper.setActive(arg_87_0._passiveskillitems[0].go, true)
	else
		gohelper.setActive(arg_87_0._passiveskillitems[0].go, false)
	end
end

function var_0_0._refreshExSkill(arg_88_0)
	for iter_88_0 = 1, 5 do
		if iter_88_0 <= arg_88_0._heroMO.exSkillLevel then
			SLFramework.UGUI.GuiHelper.SetColor(arg_88_0._exskills[iter_88_0]:GetComponent("Image"), "#feb73b")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_88_0._exskills[iter_88_0]:GetComponent("Image"), "#737373")
		end
	end
end

function var_0_0._refreshTalent(arg_89_0)
	local var_89_0 = arg_89_0._heroMO:isOwnHero()
	local var_89_1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Talent) or not var_89_0
	local var_89_2 = false
	local var_89_3 = arg_89_0._heroMO:isOtherPlayerHero()
	local var_89_4

	if var_89_3 then
		var_89_2 = arg_89_0._heroMO:getOtherPlayerIsOpenTalent()
	else
		var_89_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or arg_89_0._heroMO:isTrial()
	end

	gohelper.setActive(arg_89_0._gotalent, var_89_1)
	gohelper.setActive(arg_89_0._gotalentlock, not var_89_2)
	ZProj.UGUIHelper.SetGrayscale(arg_89_0._gotalents, not var_89_2)
	arg_89_0:_showTalentStyleBtn()

	arg_89_0._txttalentvalue.text = HeroResonanceConfig.instance:getTalentConfig(arg_89_0._heroMO.heroId, arg_89_0._heroMO.talent + 1) and arg_89_0._heroMO.talent or luaLang("character_max_overseas")
end

function var_0_0._showTalentStyleBtn(arg_90_0)
	local var_90_0 = arg_90_0._heroMO:isOwnHero()
	local var_90_1 = TalentStyleModel.instance:isUnlockStyleSystem(arg_90_0._heroMO.talent)

	if not var_90_0 and not var_90_1 and not var_90_1 then
		arg_90_0:_showTalentBtn()

		return
	end

	local var_90_2 = arg_90_0._heroMO:getHeroUseCubeStyleId()
	local var_90_3 = arg_90_0._heroMO.talentCubeInfos:getMainCubeMo()

	if var_90_2 == 0 or not var_90_3 then
		arg_90_0:_showTalentBtn()

		return
	end

	local var_90_4 = var_90_3.id
	local var_90_5 = HeroResonanceConfig.instance:getTalentStyle(var_90_4)
	local var_90_6 = var_90_5 and var_90_5[var_90_2]

	if var_90_6 then
		local var_90_7, var_90_8 = var_90_6:getStyleTagIcon()
		local var_90_9 = var_90_6._styleCo.color

		arg_90_0._imageicon.color = GameUtil.parseColor(var_90_9)

		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_90_0._imageicon, var_90_8)
		gohelper.setActive(arg_90_0._gotalentstyle, true)
		gohelper.setActive(arg_90_0._gotalents, false)
	else
		arg_90_0:_showTalentBtn()
	end
end

function var_0_0._showTalentBtn(arg_91_0)
	gohelper.setActive(arg_91_0._gotalentstyle, false)
	gohelper.setActive(arg_91_0._gotalents, true)
end

function var_0_0._onRefreshStyleIcon(arg_92_0)
	arg_92_0:_showTalentStyleBtn()
end

function var_0_0.onClose(arg_93_0)
	if arg_93_0._drag then
		arg_93_0._drag:RemoveDragBeginListener()
		arg_93_0._drag:RemoveDragEndListener()
		arg_93_0._drag:RemoveDragListener()
	end

	if arg_93_0._signatureDrag then
		arg_93_0._signatureDrag:RemoveDragBeginListener()
		arg_93_0._signatureDrag:RemoveDragEndListener()
		arg_93_0._signatureDrag:RemoveDragListener()
	end

	arg_93_0._trustclick:RemoveClickListener()
	arg_93_0._careerclick:RemoveClickListener()
	arg_93_0._signatureClick:RemoveClickListener()

	if arg_93_0._uiSpine then
		arg_93_0._uiSpine:stopVoice()
	end

	if arg_93_0._dragTweenId then
		ZProj.TweenHelper.KillById(arg_93_0._dragTweenId)

		arg_93_0._dragTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_93_0._playSpineVoice, arg_93_0)
	TaskDispatcher.cancelTask(arg_93_0._delaySetModelHide, arg_93_0)
	arg_93_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_93_0._onCloseViewFinish, arg_93_0)
	arg_93_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_93_0._onCloseFullView, arg_93_0)
	arg_93_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_93_0._onCloseView, arg_93_0)

	if arg_93_0._skillContainer then
		arg_93_0._skillContainer:onFinishreplaceSkillAnim()
		arg_93_0._skillContainer:clearDelay()
	end
end

function var_0_0.onUpdateParam(arg_94_0)
	arg_94_0._playGreetingVoices = true
	arg_94_0._heroMO = arg_94_0.viewParam

	arg_94_0:clear()
	arg_94_0:_refreshView()
end

function var_0_0.clear(arg_95_0)
	arg_95_0._simagestatic:UnLoadImage()
	arg_95_0._simagesignature:UnLoadImage()
end

function var_0_0.playCloseViewAnim(arg_96_0, arg_96_1)
	if arg_96_0._tempFunc then
		TaskDispatcher.cancelTask(arg_96_0._tempFunc, arg_96_0)
	end

	arg_96_0:playAnim(UIAnimationName.Close)

	arg_96_0._tempFunc = arg_96_1

	UIBlockMgr.instance:startBlock(arg_96_0.viewName .. "ViewCloseAnim")
	TaskDispatcher.runDelay(arg_96_0._closeAnimFinish, arg_96_0, 0.18)
end

function var_0_0._closeAnimFinish(arg_97_0)
	UIBlockMgr.instance:endBlock(arg_97_0.viewName .. "ViewCloseAnim")
	arg_97_0:_tempFunc()
end

function var_0_0.playAnim(arg_98_0, arg_98_1)
	arg_98_0._isAnim = true

	arg_98_0:setShaderKeyWord()
	arg_98_0._animator:Play(arg_98_1, arg_98_0.onAnimDone, arg_98_0)
end

function var_0_0.onAnimDone(arg_99_0)
	arg_99_0._isAnim = false

	arg_99_0:setShaderKeyWord()
end

function var_0_0.setShaderKeyWord(arg_100_0)
	if arg_100_0._isDragingSpine or arg_100_0._isAnim then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.onDestroyView(arg_101_0)
	if arg_101_0._uiSpine then
		arg_101_0._uiSpine:onDestroy()

		arg_101_0._uiSpine = nil
	end

	arg_101_0._simageplayerbg:UnLoadImage()
	arg_101_0._simagebg:UnLoadImage()
	arg_101_0:clear()
	TaskDispatcher.cancelTask(arg_101_0._closeAnimFinish, arg_101_0)
	TaskDispatcher.cancelTask(arg_101_0._delaySetModelHide, arg_101_0)
	TaskDispatcher.cancelTask(arg_101_0._playSpineVoice, arg_101_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function var_0_0._checkPlaySpecialBodyMotion(arg_102_0)
	if not arg_102_0._heroMO:isOwnHero() then
		return
	end

	local var_102_0, var_102_1, var_102_2 = CharacterModel.instance:isCanPlayReplaceSkillAnim(arg_102_0._heroMO)

	if var_102_0 and var_102_2 and not string.nilorempty(var_102_2.specialLive2d) then
		local var_102_3 = string.split(var_102_2.specialLive2d, "#")

		if not string.nilorempty(var_102_3[3]) then
			local var_102_4 = "b_" .. var_102_3[3]
			local var_102_5 = var_102_3[4] and tonumber(var_102_3[4]) or 0

			local function var_102_6()
				if arg_102_0._uiSpine then
					arg_102_0._uiSpine:setActionEventCb(nil, arg_102_0)

					if arg_102_0._greetingVoices and #arg_102_0._greetingVoices > 0 then
						arg_102_0._uiSpine:playVoice(arg_102_0._greetingVoices[1], nil, arg_102_0._txtanacn, arg_102_0._txtanaen, arg_102_0._gocontentbg)
					end
				end
			end

			arg_102_0._uiSpine:playSpecialMotion(var_102_4, false, var_102_5)
			arg_102_0._uiSpine:setActionEventCb(var_102_6, arg_102_0)

			return true
		end
	end
end

return var_0_0
