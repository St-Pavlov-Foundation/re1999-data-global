module("modules.logic.character.view.CharacterTalentView", package.seeall)

local var_0_0 = class("CharacterTalentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_bg")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_righticon")
	arg_1_0._simagerighticon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_righticon2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_mask")
	arg_1_0._simageglowleftdown = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/glow_leftdown")
	arg_1_0._simageglowrighttop = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/glow_righttop")
	arg_1_0._simagegglowrighdown = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/glow_righdown")
	arg_1_0._simageglowmiddle = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/glow_middle")
	arg_1_0._simageglow = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/bg_04/glow")
	arg_1_0._simageglow2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/icon04/glow")
	arg_1_0._simagecurve1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/bg_04/bg04/curve01")
	arg_1_0._simagecurve2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/bg_04/bg04/curve02")
	arg_1_0._simagecurve3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/bg_04/bg04/curve03")
	arg_1_0._simagequxian3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/bg_04/quxian/quxian3")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/bg_02/image")
	arg_1_0._golinemax = gohelper.findChild(arg_1_0.viewGO, "commen/rentouxiang/ani/bg_02/#linemax")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/bg01/simage_line")
	arg_1_0._simagezhigantu = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/rentouxiang/ani/zhigantu")
	arg_1_0._gotouPos = gohelper.findChild(arg_1_0.viewGO, "commen/rentouxiang/ani/tou")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnchessboard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_chessboard")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "#btn_chessboard/#go_meshContainer")
	arg_1_0._gomeshItem = gohelper.findChild(arg_1_0.viewGO, "#btn_chessboard/#go_meshContainer/#go_meshItem")
	arg_1_0._gochessContainer = gohelper.findChild(arg_1_0.viewGO, "#btn_chessboard/#go_chessContainer")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "#btn_chessboard/#go_chessContainer/#go_chessitem")
	arg_1_0._goattrContent = gohelper.findChild(arg_1_0.viewGO, "attribute/#go_attrContent")
	arg_1_0._goattrEmpty = gohelper.findChild(arg_1_0.viewGO, "attribute/#go_attrEmpty")
	arg_1_0._goattrItem = gohelper.findChild(arg_1_0.viewGO, "attribute/#go_attrContent/#go_attrItem")
	arg_1_0._btninsight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_insight")
	arg_1_0._txttalentcn = gohelper.findChildText(arg_1_0.viewGO, "#btn_insight/txt")
	arg_1_0._txtinsightLv = gohelper.findChildText(arg_1_0.viewGO, "#btn_insight/#txt_insightLv")
	arg_1_0._gotalentreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_insight/#go_talentreddot")
	arg_1_0._goEsonan = gohelper.findChild(arg_1_0.viewGO, "commen/rentouxiang/ani/icon02/esonan")
	arg_1_0._goEsoning = gohelper.findChild(arg_1_0.viewGO, "commen/rentouxiang/ani/icon02/easoning")
	arg_1_0._btnstyle = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_style")
	arg_1_0._gostylechange = gohelper.findChild(arg_1_0.viewGO, "#btn_chessboard/#go_stylechange")
	arg_1_0._txtstyle = gohelper.findChildText(arg_1_0.viewGO, "#btn_chessboard/#go_stylechange/#txt_label")
	arg_1_0._styleslot = gohelper.findChildImage(arg_1_0.viewGO, "#btn_chessboard/#go_stylechange/slot")
	arg_1_0._styleicon = gohelper.findChildImage(arg_1_0.viewGO, "#btn_chessboard/#go_stylechange/slot/icon")
	arg_1_0._styleglow = gohelper.findChildImage(arg_1_0.viewGO, "#btn_chessboard/#go_stylechange/slot/glow")
	arg_1_0._styleupdate = gohelper.findChild(arg_1_0.viewGO, "#btn_chessboard/#go_stylechange/update")
	arg_1_0._dropresonategroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#btn_chessboard/#drop_resonategroup")
	arg_1_0._txtgroupname = gohelper.findChildText(arg_1_0.viewGO, "#btn_chessboard/#drop_resonategroup/txt_groupname")
	arg_1_0._btnchangetemplatename = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#btn_chessboard/#drop_resonategroup/#btn_changetemplatename")
	arg_1_0._dropClick = gohelper.getClick(arg_1_0._dropresonategroup.gameObject)
	arg_1_0._goStyleRed = gohelper.findChild(arg_1_0.viewGO, "#btn_style/#go_talentreddot")
	arg_1_0._txtTitleStyle = gohelper.findChildText(arg_1_0.viewGO, "#btn_style/txt_style")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchessboard:AddClickListener(arg_2_0._btnchessboardOnClick, arg_2_0)
	arg_2_0._btninsight:AddClickListener(arg_2_0._btninsightOnClick, arg_2_0)
	arg_2_0._btnstyle:AddClickListener(arg_2_0._btnstyleOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.RefreshCubeList, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.playTalentViewBackAni, arg_2_0._onplayBackAni, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_2_0._onUseTalentStyleReply, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.RenameTalentTemplateReply, arg_2_0._onRenameTalentTemplateReply, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, arg_2_0._onUseTalentTemplateReply, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onTalentStyleRead, arg_2_0._refreshTalentStyleRed, arg_2_0)
	arg_2_0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_2_0._onUseShareCode, arg_2_0)
	arg_2_0._dropresonategroup:AddOnValueChanged(arg_2_0._opDropdownChange, arg_2_0)
	arg_2_0._btnchangetemplatename:AddClickListener(arg_2_0._onBtnChangeTemplateName, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchessboard:RemoveClickListener()
	arg_3_0._btninsight:RemoveClickListener()
	arg_3_0._btnstyle:RemoveClickListener()
	arg_3_0._dropresonategroup:RemoveOnValueChanged()
	arg_3_0._btnchangetemplatename:RemoveClickListener()
end

function var_0_0._btnchessboardOnClick(arg_4_0)
	if arg_4_0.rentou_ani then
		arg_4_0.rentou_ani.enabled = true

		gohelper.setActive(arg_4_0.rentou_ani.gameObject, true)
		arg_4_0.rentou_ani:Play("1_3", 0, 0)
	end

	arg_4_0._rentou_in_ani.enabled = false

	gohelper.setActive(arg_4_0._rentou_in_ani.gameObject, false)
	arg_4_0:_hideTalentStyle()
	arg_4_0.view_ani:Play("charactertalentup_out")
	arg_4_0.bg_ani:Play("ani_1_3")
	arg_4_0.chess_ani:Play("chessboard_click")
	CharacterController.instance:openCharacterTalentChessView(arg_4_0.hero_id)
end

function var_0_0._btninsightOnClick(arg_5_0)
	if arg_5_0.rentou_ani then
		arg_5_0.rentou_ani.enabled = true

		gohelper.setActive(arg_5_0.rentou_ani.gameObject, true)
		arg_5_0.rentou_ani:Play("1_2", 0, 0)
	end

	arg_5_0._rentou_in_ani.enabled = false

	gohelper.setActive(arg_5_0._rentou_in_ani.gameObject, false)
	arg_5_0:_hideTalentStyle()
	arg_5_0.view_ani:Play("charactertalentup_out")
	arg_5_0.bg_ani:Play("ani_1_2")
	arg_5_0.chess_ani:Play("chessboard_out")

	if not ViewMgr.instance:isOpen(ViewName.CharacterTalentLevelUpView) or not arg_5_0.viewParam.isBack then
		CharacterController.instance:openCharacterTalentLevelUpView({
			arg_5_0.hero_id
		})
	end
end

function var_0_0._openCharacterTalentLevelUpView(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._openCharacterTalentLevelUpView, arg_6_0)
	CharacterController.instance:openCharacterTalentLevelUpView({
		arg_6_0.hero_id
	})
end

function var_0_0._btnstyleOnClick(arg_7_0)
	CharacterController.instance:openCharacterTalentStyleView({
		hero_id = arg_7_0.hero_id
	})
end

function var_0_0._onUseTalentStyleReply(arg_8_0)
	arg_8_0:_refreshUI()
	arg_8_0:_initTemplateList()
	arg_8_0:_refreshStyleTag()
	arg_8_0:_refreshMainStyleCubeItem()
	TaskDispatcher.cancelTask(arg_8_0._hideStyleUpdateAnim, arg_8_0)
	gohelper.setActive(arg_8_0._styleupdate, true)
	TaskDispatcher.runDelay(arg_8_0._hideStyleUpdateAnim, arg_8_0, 0.6)
end

function var_0_0._hideStyleUpdateAnim(arg_9_0)
	gohelper.setActive(arg_9_0._styleupdate, false)
end

function var_0_0._onplayBackAni(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not arg_10_2 then
		arg_10_0.view_ani:Play("charactertalentup_in")
		arg_10_0.chess_ani:Play("chessboard_in")
	end

	if arg_10_3 then
		arg_10_0.bg_ani:Play(arg_10_3)
	end

	if arg_10_3 == "ani_3_1" then
		arg_10_0.chess_ani:Play("chessboard_back")
	end

	arg_10_0._rentou_in_ani.enabled = false

	if arg_10_0.rentou_ani then
		arg_10_0.rentou_ani.enabled = true

		gohelper.setActive(arg_10_0.rentou_ani.gameObject, true)
		arg_10_0.rentou_ani:Play(arg_10_1, 0, 0)
	end

	gohelper.setActive(arg_10_0._rentou_in_ani.gameObject, false)

	if not arg_10_2 then
		arg_10_0:_showTalentStyle()
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.CharacterTalentViewAnimFinished)

	if arg_10_4 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onReturnTalentView, arg_10_0.hero_id)
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_11_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_11_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_11_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_11_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	arg_11_0._simageglowleftdown:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_left"))
	arg_11_0._simageglowrighttop:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_righttop"))
	arg_11_0._simagegglowrighdown:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_rightdown"))
	arg_11_0._simageglowmiddle:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_middle"))
	arg_11_0._simageglow:LoadImage(ResUrl.getCharacterTalentUpTexture("shinne"))
	arg_11_0._simageglow2:LoadImage(ResUrl.getCharacterTalentUpTexture("shinne"))
	arg_11_0._simagecurve1:LoadImage(ResUrl.getCharacterTalentUpTexture("curve02"))
	arg_11_0._simagecurve2:LoadImage(ResUrl.getCharacterTalentUpTexture("curve03"))
	arg_11_0._simagecurve3:LoadImage(ResUrl.getCharacterTalentUpTexture("curve04"))
	arg_11_0._simagequxian3:LoadImage(ResUrl.getCharacterTalentUpTexture("quxian3"))
	arg_11_0._simagebg2:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_top"))
	arg_11_0._simageline:LoadImage(ResUrl.getCharacterTalentUpIcon("line001"))
	arg_11_0._simagezhigantu:LoadImage(ResUrl.getCharacterTalentUpTexture("zhigan"))

	arg_11_0.view_ani = gohelper.findChildComponent(arg_11_0.viewGO, "", typeof(UnityEngine.Animator))
	arg_11_0.bg_ani = gohelper.findChildComponent(arg_11_0.viewGO, "commen/rentouxiang/ani", typeof(UnityEngine.Animator))
	arg_11_0.chess_ani = gohelper.findChildComponent(arg_11_0.viewGO, "#btn_chessboard", typeof(UnityEngine.Animator))
	arg_11_0._rentou_in_ani = gohelper.findChildComponent(arg_11_0.viewGO, "commen/rentouxiang/ani/tou/tou_in", typeof(UnityEngine.Animator))

	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_open)
	gohelper.addUIClickAudio(arg_11_0._btnchessboard.gameObject, AudioEnum.Talent.play_ui_resonate_property_open)
	gohelper.addUIClickAudio(arg_11_0._btninsight.gameObject, AudioEnum.UI.play_ui_admission_open)

	arg_11_0._animStylebtn = arg_11_0._btnstyle.gameObject:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0._playAni(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._ani:StartPlayback()

	arg_13_0._ani.speed = arg_13_2 and 1 or -1

	arg_13_0._ani:Play(arg_13_1)
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0._tou_url = "ui/viewres/character/charactertalentup/tou.prefab"
	arg_14_0._tou_loader = MultiAbLoader.New()

	arg_14_0._tou_loader:addPath(arg_14_0._tou_url)
	arg_14_0._tou_loader:startLoad(arg_14_0._addTouPrefab, arg_14_0)
	arg_14_0:_refreshUI()
	CharacterController.instance:statTalentStart(arg_14_0.hero_id)
	CharacterController.instance:dispatchEvent(CharacterEvent.CharacterTalentViewAnimFinished)
	arg_14_0:_hideStyleUpdateAnim()
	arg_14_0:_showTalentStyle()
end

function var_0_0._refreshUI(arg_15_0)
	arg_15_0.cell_length = 56.2
	arg_15_0.hero_id = arg_15_0.viewParam.heroid
	arg_15_0.hero_mo_data = HeroModel.instance:getByHeroId(arg_15_0.hero_id)
	arg_15_0._mainCubeId = arg_15_0.hero_mo_data.talentCubeInfos.own_main_cube_id

	gohelper.setActive(arg_15_0._gotalentreddot, CharacterModel.instance:heroTalentRedPoint(arg_15_0.hero_id))

	local var_15_0 = arg_15_0.hero_mo_data:getTalentGain()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		table.insert(var_15_1, iter_15_1)
	end

	table.sort(var_15_1, function(arg_16_0, arg_16_1)
		return HeroConfig.instance:getIDByAttrType(arg_16_0.key) < HeroConfig.instance:getIDByAttrType(arg_16_1.key)
	end)
	gohelper.setActive(arg_15_0._goattrEmpty, not (GameUtil.getTabLen(var_15_1) > 0))
	gohelper.setActive(arg_15_0._goattrContent, GameUtil.getTabLen(var_15_1) > 0)
	gohelper.CreateObjList(arg_15_0, arg_15_0._onItemShow, var_15_1, arg_15_0._goattrContent, arg_15_0._goattrItem)
	arg_15_0:_setChessboardData()

	local var_15_2 = HeroResonanceConfig.instance:getTalentConfig(arg_15_0.hero_id, arg_15_0.hero_mo_data.talent + 1) == nil

	arg_15_0._txtinsightLv.text = not var_15_2 and arg_15_0.hero_mo_data.talent or luaLang("character_max_overseas")
	arg_15_0._txttalentcn.text = luaLang("talent_charactertalent_txt" .. CharacterEnum.TalentTxtByHeroType[arg_15_0.hero_mo_data.config.heroType])

	gohelper.setActive(arg_15_0._goEsonan, arg_15_0.hero_mo_data.config.heroType ~= CharacterEnum.HumanHeroType)
	gohelper.setActive(arg_15_0._goEsoning, arg_15_0.hero_mo_data.config.heroType == CharacterEnum.HumanHeroType)
	gohelper.setActive(arg_15_0._golinemax, var_15_2)

	local var_15_3 = luaLang("talent_style_title_cn_" .. CharacterEnum.TalentTxtByHeroType[arg_15_0.hero_mo_data.config.heroType])

	arg_15_0._txtTitleStyle.text = var_15_3

	arg_15_0:_initTemplateList()
	arg_15_0:_refreshTalentStyleRed()
end

function var_0_0._addTouPrefab(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:getAssetItem(arg_17_0._tou_url)

	if var_17_0 then
		local var_17_1 = var_17_0:GetResource(arg_17_0._tou_url)
		local var_17_2 = gohelper.clone(var_17_1, arg_17_0._gotouPos, "tou")

		if var_17_2 then
			gohelper.setActive(var_17_2, false)

			arg_17_0.rentou_ani = var_17_2:GetComponent(typeof(UnityEngine.Animator))
		end

		if arg_17_0.viewParam.isBack then
			arg_17_0:_btninsightOnClick()
		end
	end
end

function var_0_0._onItemShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_1.transform
	local var_18_1 = var_18_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_18_2 = var_18_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_18_3 = var_18_0:Find("value"):GetComponent(gohelper.Type_TextMesh)
	local var_18_4 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_18_2.key))

	if var_18_4.type ~= 1 then
		arg_18_2.value = tonumber(string.format("%.3f", arg_18_2.value / 10)) .. "%"
	else
		arg_18_2.value = math.floor(arg_18_2.value)
	end

	var_18_3.text = arg_18_2.value
	var_18_2.text = var_18_4.name

	UISpriteSetMgr.instance:setCommonSprite(var_18_1, "icon_att_" .. var_18_4.id, true)
end

function var_0_0.getRabbetCell(arg_19_0)
	return arg_19_0._rabbet_cell
end

function var_0_0._setChessboardData(arg_20_0)
	local var_20_0 = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(arg_20_0.hero_mo_data.heroId, arg_20_0.hero_mo_data.talent), ",")

	if arg_20_0.last_talent_level ~= arg_20_0.hero_mo_data.talent then
		arg_20_0:_releaseCellList()

		arg_20_0._rabbet_cell = {}
		arg_20_0._rabbet_cell_list = {}

		local var_20_1 = 0

		for iter_20_0 = 0, var_20_0[2] - 1 do
			arg_20_0._rabbet_cell[iter_20_0] = {}

			for iter_20_1 = 0, var_20_0[1] - 1 do
				local var_20_2

				if var_20_1 < arg_20_0._gomeshContainer.transform.childCount then
					var_20_2 = arg_20_0._gomeshContainer.transform:GetChild(var_20_1)
				else
					var_20_2 = gohelper.clone(arg_20_0._gomeshItem, arg_20_0._gomeshContainer)
				end

				local var_20_3 = iter_20_1 - (var_20_0[1] - 1) / 2
				local var_20_4 = (var_20_0[2] - 1) / 2 - iter_20_0

				recthelper.setAnchor(var_20_2.transform, var_20_3 * arg_20_0.cell_length, var_20_4 * arg_20_0.cell_length)

				arg_20_0._rabbet_cell[iter_20_0][iter_20_1] = ResonanceCellItem.New(var_20_2.gameObject, iter_20_1, iter_20_0, arg_20_0)

				table.insert(arg_20_0._rabbet_cell_list, arg_20_0._rabbet_cell[iter_20_0][iter_20_1])

				var_20_1 = var_20_1 + 1
			end
		end
	end

	arg_20_0.last_talent_level = arg_20_0.hero_mo_data.talent
	arg_20_0.cube_data = arg_20_0.hero_mo_data.talentCubeInfos.data_list

	for iter_20_2, iter_20_3 in ipairs(arg_20_0._rabbet_cell_list) do
		iter_20_3.is_filled = false
	end

	gohelper.CreateObjList(arg_20_0, arg_20_0._onCubeItemShow, arg_20_0.cube_data, arg_20_0._gochessContainer, arg_20_0._gochessitem)

	for iter_20_4, iter_20_5 in ipairs(arg_20_0._rabbet_cell_list) do
		iter_20_5:SetNormal()
	end
end

function var_0_0._onCubeItemShow(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1.transform
	local var_21_1 = var_21_0:GetComponent(gohelper.Type_Image)
	local var_21_2 = gohelper.findChildImage(arg_21_1, "icon")
	local var_21_3 = gohelper.findChildImage(arg_21_1, "glow")
	local var_21_4 = gohelper.findChildImage(arg_21_1, "cell")
	local var_21_5 = HeroResonanceConfig.instance:getCubeMatrix(arg_21_2.cubeId)
	local var_21_6 = arg_21_0:_rotationMatrix(var_21_5, arg_21_2.direction)

	UISpriteSetMgr.instance:setCharacterTalentSprite(var_21_1, "ky_" .. HeroResonanceConfig.instance:getCubeConfig(arg_21_2.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(var_21_2, HeroResonanceConfig.instance:getCubeConfig(arg_21_2.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(var_21_3, "glow_" .. HeroResonanceConfig.instance:getCubeConfig(arg_21_2.cubeId).icon, true)

	local var_21_7 = arg_21_0._rabbet_cell[arg_21_2.posY][arg_21_2.posX].transform.anchoredPosition.x
	local var_21_8 = arg_21_0._rabbet_cell[arg_21_2.posY][arg_21_2.posX].transform.anchoredPosition.y

	transformhelper.setLocalRotation(var_21_0, 0, 0, -arg_21_2.direction * 90)

	local var_21_9 = arg_21_0.cell_length * GameUtil.getTabLen(var_21_5[0])
	local var_21_10 = arg_21_0.cell_length * GameUtil.getTabLen(var_21_5)
	local var_21_11 = arg_21_2.direction % 2 == 0
	local var_21_12 = var_21_7 + (var_21_11 and var_21_9 or var_21_10) / 2
	local var_21_13 = var_21_8 + -(var_21_11 and var_21_10 or var_21_9) / 2
	local var_21_14 = var_21_12 - arg_21_0.cell_length / 2
	local var_21_15 = var_21_13 + arg_21_0.cell_length / 2

	recthelper.setAnchor(var_21_0, var_21_14, var_21_15)

	local var_21_16 = {}
	local var_21_17 = GameUtil.getTabLen(var_21_6) - 1
	local var_21_18 = GameUtil.getTabLen(var_21_6[0]) - 1

	for iter_21_0 = 0, var_21_17 do
		for iter_21_1 = 0, var_21_18 do
			if var_21_6[iter_21_0][iter_21_1] == 1 then
				table.insert(var_21_16, {
					arg_21_2.posX + iter_21_1,
					arg_21_2.posY + iter_21_0
				})
			end
		end
	end

	for iter_21_2, iter_21_3 in ipairs(var_21_16) do
		arg_21_0._rabbet_cell[iter_21_3[2]][iter_21_3[1]].is_filled = true

		arg_21_0._rabbet_cell[iter_21_3[2]][iter_21_3[1]]:setCellData(arg_21_2)
	end

	if arg_21_0._mainCubeId == arg_21_2.cubeId then
		arg_21_0._mainCubeItem = {
			bg = var_21_1,
			icon = var_21_2,
			glow_icon = var_21_3,
			cell_icon = var_21_4,
			anim = var_21_4
		}

		arg_21_0:_refreshMainStyleCubeItem()
	else
		gohelper.setActive(var_21_4.gameObject, false)
	end
end

function var_0_0._refreshMainStyleCubeItem(arg_22_0)
	local var_22_0 = HeroResonanceConfig.instance:getCubeConfig(arg_22_0._mainCubeId).icon
	local var_22_1 = "ky_" .. var_22_0
	local var_22_2 = var_22_0
	local var_22_3 = "glow_" .. var_22_0
	local var_22_4 = string.split(var_22_0, "_")
	local var_22_5 = "gz_" .. var_22_4[#var_22_4]
	local var_22_6 = arg_22_0.hero_mo_data:getHeroUseStyleCubeId()
	local var_22_7 = HeroResonanceConfig.instance:getCubeConfig(var_22_6)
	local var_22_8 = var_22_6 == arg_22_0._mainCubeId

	if not var_22_8 and var_22_7 then
		local var_22_9 = var_22_7.icon

		if not string.nilorempty(var_22_9) then
			var_22_1 = "ky_" .. var_22_9
			var_22_2 = "mk_" .. var_22_9
			var_22_3 = var_22_2
		end
	end

	if arg_22_0._mainCubeItem then
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_22_0._mainCubeItem.bg, var_22_1, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_22_0._mainCubeItem.icon, var_22_2, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_22_0._mainCubeItem.glow_icon, var_22_3, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_22_0._mainCubeItem.cell_icon, var_22_5, true)
		gohelper.setActive(arg_22_0._mainCubeItem.cell_icon.gameObject, not var_22_8)
	end
end

function var_0_0.playChessIconOutAni(arg_23_0)
	if arg_23_0.cube_data then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.cube_data) do
			arg_23_0._gochessContainer.transform:GetChild(iter_23_0 - 1):GetComponent(typeof(UnityEngine.Animator)):Play("chessitem_out")
		end
	end
end

function var_0_0._rotationMatrix(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1

	while arg_24_2 > 0 do
		var_24_0 = {}

		local var_24_1 = GameUtil.getTabLen(arg_24_1)
		local var_24_2 = GameUtil.getTabLen(arg_24_1[0])

		for iter_24_0 = 0, var_24_2 - 1 do
			var_24_0[iter_24_0] = {}

			for iter_24_1 = 0, var_24_1 - 1 do
				var_24_0[iter_24_0][iter_24_1] = arg_24_1[var_24_1 - iter_24_1 - 1][iter_24_0]
			end
		end

		arg_24_2 = arg_24_2 - 1

		if arg_24_2 > 0 then
			arg_24_1 = var_24_0
		end
	end

	return var_24_0
end

function var_0_0._releaseCellList(arg_25_0)
	if arg_25_0._rabbet_cell_list then
		for iter_25_0, iter_25_1 in ipairs(arg_25_0._rabbet_cell_list) do
			iter_25_1:releaseSelf()
		end

		arg_25_0._rabbet_cell_list = nil
	end
end

function var_0_0._showTalentStyle(arg_26_0)
	local var_26_0 = TalentStyleModel.instance:isUnlockStyleSystem(arg_26_0.hero_mo_data.talent)

	TalentStyleModel.instance:refreshUnlockInfo(arg_26_0.hero_id)

	if var_26_0 then
		arg_26_0:_refreshStyleTag()
	end

	gohelper.setActive(arg_26_0._gostylechange.gameObject, var_26_0)
	gohelper.setActive(arg_26_0._btnstyle.gameObject, var_26_0)

	if var_26_0 then
		if arg_26_0.hero_mo_data.isShowTalentStyleRed and TalentStyleModel.instance:isPlayStyleEnterBtnAnim(arg_26_0.hero_id) then
			arg_26_0._animStylebtn:Play("unlock", 0, 0)
			TalentStyleModel.instance:setPlayStyleEnterBtnAnim(arg_26_0.hero_id)
		else
			arg_26_0._animStylebtn:Play("open", 0, 0)
		end
	end
end

function var_0_0._hideTalentStyle(arg_27_0)
	return
end

function var_0_0._refreshStyleTag(arg_28_0)
	local var_28_0 = arg_28_0.hero_mo_data:getHeroUseCubeStyleId(arg_28_0.hero_id)
	local var_28_1 = TalentStyleModel.instance:getTalentStyle(arg_28_0._mainCubeId, var_28_0)
	local var_28_2, var_28_3 = var_28_1:getStyleTag()
	local var_28_4, var_28_5 = var_28_1:getStyleTagIcon()

	arg_28_0._txtstyle.text = var_28_2

	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_28_0._styleslot, var_28_5, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_28_0._styleicon, var_28_4, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_28_0._styleglow, var_28_4, true)
end

function var_0_0._initTemplateList(arg_29_0)
	table.sort(arg_29_0.hero_mo_data.talentTemplates, CharacterTalentChessView.sortTemplate)

	local var_29_0 = luaLang("talent_charactertalentchess_template" .. CharacterEnum.TalentTxtByHeroType[arg_29_0.hero_mo_data.config.heroType])
	local var_29_1 = {}
	local var_29_2 = TalentStyleModel.instance:isUnlockStyleSystem(arg_29_0.hero_mo_data.talent)

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.hero_mo_data.talentTemplates) do
		local var_29_3 = string.nilorempty(iter_29_1.name) and var_29_0 .. iter_29_0 or iter_29_1.name

		if var_29_2 then
			local var_29_4 = TalentStyleModel.instance:getTalentStyle(arg_29_0._mainCubeId, iter_29_1.style)
			local var_29_5 = var_29_4 and var_29_4._styleCo and var_29_4._styleCo.tagicon

			if not string.nilorempty(var_29_5) then
				local var_29_6 = tonumber(var_29_5) - 1

				var_29_3 = string.format("<sprite=%s>", var_29_6) .. var_29_3
			end
		end

		table.insert(var_29_1, var_29_3)

		if iter_29_1.id == arg_29_0.hero_mo_data.useTalentTemplateId then
			arg_29_0._curSelectTemplateIndex = iter_29_0
			arg_29_0._txtgroupname.text = var_29_3
		end
	end

	arg_29_0._dropresonategroup:ClearOptions()
	arg_29_0._dropresonategroup:AddOptions(var_29_1)
	arg_29_0._dropresonategroup:SetValue(arg_29_0._curSelectTemplateIndex - 1)

	arg_29_0._templateInitDone = true
end

function var_0_0._onBtnChangeTemplateName(arg_30_0)
	ViewMgr.instance:openView(ViewName.CharacterTalentModifyNameView, {
		arg_30_0.hero_mo_data.heroId,
		arg_30_0.hero_mo_data.talentTemplates[arg_30_0._curSelectTemplateIndex].id
	})
end

function var_0_0.sortTemplate(arg_31_0, arg_31_1)
	return arg_31_0.id < arg_31_1.id
end

function var_0_0._opDropdownChange(arg_32_0, arg_32_1)
	arg_32_1 = arg_32_1 or 0

	local var_32_0 = arg_32_1 + 1

	if arg_32_0._curSelectTemplateIndex ~= var_32_0 then
		arg_32_0._curSelectTemplateIndex = var_32_0

		HeroRpc.instance:UseTalentTemplateRequest(arg_32_0.hero_mo_data.heroId, arg_32_0.hero_mo_data.talentTemplates[var_32_0].id)
	end
end

function var_0_0._onDropClick(arg_33_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function var_0_0._onRenameTalentTemplateReply(arg_34_0)
	arg_34_0:_initTemplateList()
end

function var_0_0._onUseTalentTemplateReply(arg_35_0)
	arg_35_0:_showTemplateName()
	arg_35_0:_refreshStyleTag()
	arg_35_0:_refreshMainStyleCubeItem()
	TaskDispatcher.cancelTask(arg_35_0._hideStyleUpdateAnim, arg_35_0)
	gohelper.setActive(arg_35_0._styleupdate, true)
	TaskDispatcher.runDelay(arg_35_0._hideStyleUpdateAnim, arg_35_0, 0.6)
	GameFacade.showToast(ToastEnum.ChangeTalentTemplate)
end

function var_0_0._showTemplateName(arg_36_0)
	for iter_36_0, iter_36_1 in ipairs(arg_36_0.hero_mo_data.talentTemplates) do
		if iter_36_1.id == arg_36_0.hero_mo_data.useTalentTemplateId then
			local var_36_0 = luaLang("talent_charactertalentchess_template" .. CharacterEnum.TalentTxtByHeroType[arg_36_0.hero_mo_data.config.heroType])
			local var_36_1 = string.nilorempty(iter_36_1.name) and var_36_0 .. arg_36_0._curSelectTemplateIndex or iter_36_1.name
			local var_36_2 = TalentStyleModel.instance:getTalentStyle(arg_36_0._mainCubeId, iter_36_1.style)
			local var_36_3 = var_36_2 and var_36_2._styleCo and var_36_2._styleCo.tagicon

			if not string.nilorempty(var_36_3) then
				local var_36_4 = tonumber(var_36_3) - 1

				var_36_1 = string.format("<sprite=%s>", var_36_4) .. var_36_1
			end

			arg_36_0._txtgroupname.text = var_36_1
		end
	end
end

function var_0_0._refreshTalentStyleRed(arg_37_0)
	local var_37_0 = arg_37_0.hero_mo_data.isShowTalentStyleRed

	gohelper.setActive(arg_37_0._goStyleRed, var_37_0)
end

function var_0_0._onUseShareCode(arg_38_0, arg_38_1)
	arg_38_0:_refreshUI()
end

function var_0_0.onClose(arg_39_0)
	if arg_39_0._tou_loader then
		arg_39_0._tou_loader:dispose()
	end

	arg_39_0:_releaseCellList()
	TaskDispatcher.cancelTask(arg_39_0._openCharacterTalentLevelUpView, arg_39_0)
	CharacterController.instance:statTalentEnd(arg_39_0.hero_id)
	TaskDispatcher.cancelTask(arg_39_0._hideStyleUpdateAnim, arg_39_0)
end

function var_0_0.onDestroyView(arg_40_0)
	arg_40_0._simagebg:UnLoadImage()
	arg_40_0._simagelefticon:UnLoadImage()
	arg_40_0._simagerighticon:UnLoadImage()
	arg_40_0._simagerighticon2:UnLoadImage()
	arg_40_0._simagemask:UnLoadImage()
	arg_40_0._simageglowleftdown:UnLoadImage()
	arg_40_0._simageglowrighttop:UnLoadImage()
	arg_40_0._simagegglowrighdown:UnLoadImage()
	arg_40_0._simageglowmiddle:UnLoadImage()
	arg_40_0._simageglow:UnLoadImage()
	arg_40_0._simageglow2:UnLoadImage()
	arg_40_0._simagecurve1:UnLoadImage()
	arg_40_0._simagecurve2:UnLoadImage()
	arg_40_0._simagecurve3:UnLoadImage()
	arg_40_0._simagequxian3:UnLoadImage()
	arg_40_0._simagebg2:UnLoadImage()
	arg_40_0._simageline:UnLoadImage()
	arg_40_0._simagezhigantu:UnLoadImage()
end

return var_0_0
