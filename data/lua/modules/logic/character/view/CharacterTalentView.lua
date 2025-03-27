module("modules.logic.character.view.CharacterTalentView", package.seeall)

slot0 = class("CharacterTalentView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_bg")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_righticon")
	slot0._simagerighticon2 = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_righticon2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_mask")
	slot0._simageglowleftdown = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/glow_leftdown")
	slot0._simageglowrighttop = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/glow_righttop")
	slot0._simagegglowrighdown = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/glow_righdown")
	slot0._simageglowmiddle = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/glow_middle")
	slot0._simageglow = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/bg_04/glow")
	slot0._simageglow2 = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/icon04/glow")
	slot0._simagecurve1 = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/bg_04/bg04/curve01")
	slot0._simagecurve2 = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/bg_04/bg04/curve02")
	slot0._simagecurve3 = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/bg_04/bg04/curve03")
	slot0._simagequxian3 = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/bg_04/quxian/quxian3")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/bg_02/image")
	slot0._golinemax = gohelper.findChild(slot0.viewGO, "commen/rentouxiang/ani/bg_02/#linemax")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/bg01/simage_line")
	slot0._simagezhigantu = gohelper.findChildSingleImage(slot0.viewGO, "commen/rentouxiang/ani/zhigantu")
	slot0._gotouPos = gohelper.findChild(slot0.viewGO, "commen/rentouxiang/ani/tou")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnchessboard = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_chessboard")
	slot0._gomeshContainer = gohelper.findChild(slot0.viewGO, "#btn_chessboard/#go_meshContainer")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "#btn_chessboard/#go_meshContainer/#go_meshItem")
	slot0._gochessContainer = gohelper.findChild(slot0.viewGO, "#btn_chessboard/#go_chessContainer")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "#btn_chessboard/#go_chessContainer/#go_chessitem")
	slot0._goattrContent = gohelper.findChild(slot0.viewGO, "attribute/#go_attrContent")
	slot0._goattrEmpty = gohelper.findChild(slot0.viewGO, "attribute/#go_attrEmpty")
	slot0._goattrItem = gohelper.findChild(slot0.viewGO, "attribute/#go_attrContent/#go_attrItem")
	slot0._btninsight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_insight")
	slot0._txttalentcn = gohelper.findChildText(slot0.viewGO, "#btn_insight/txt")
	slot0._txtinsightLv = gohelper.findChildText(slot0.viewGO, "#btn_insight/#txt_insightLv")
	slot0._gotalentreddot = gohelper.findChild(slot0.viewGO, "#btn_insight/#go_talentreddot")
	slot0._goEsonan = gohelper.findChild(slot0.viewGO, "commen/rentouxiang/ani/icon02/esonan")
	slot0._goEsoning = gohelper.findChild(slot0.viewGO, "commen/rentouxiang/ani/icon02/easoning")
	slot0._btnstyle = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_style")
	slot0._gostylechange = gohelper.findChild(slot0.viewGO, "#btn_chessboard/#go_stylechange")
	slot0._txtstyle = gohelper.findChildText(slot0.viewGO, "#btn_chessboard/#go_stylechange/#txt_label")
	slot0._styleslot = gohelper.findChildImage(slot0.viewGO, "#btn_chessboard/#go_stylechange/slot")
	slot0._styleicon = gohelper.findChildImage(slot0.viewGO, "#btn_chessboard/#go_stylechange/slot/icon")
	slot0._styleglow = gohelper.findChildImage(slot0.viewGO, "#btn_chessboard/#go_stylechange/slot/glow")
	slot0._styleupdate = gohelper.findChild(slot0.viewGO, "#btn_chessboard/#go_stylechange/update")
	slot0._dropresonategroup = gohelper.findChildDropdown(slot0.viewGO, "#btn_chessboard/#drop_resonategroup")
	slot0._txtgroupname = gohelper.findChildText(slot0.viewGO, "#btn_chessboard/#drop_resonategroup/txt_groupname")
	slot0._btnchangetemplatename = gohelper.findChildClickWithAudio(slot0.viewGO, "#btn_chessboard/#drop_resonategroup/#btn_changetemplatename")
	slot0._dropClick = gohelper.getClick(slot0._dropresonategroup.gameObject)
	slot0._goStyleRed = gohelper.findChild(slot0.viewGO, "#btn_style/#go_talentreddot")
	slot0._txtTitleStyle = gohelper.findChildText(slot0.viewGO, "#btn_style/txt_style")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnchessboard:AddClickListener(slot0._btnchessboardOnClick, slot0)
	slot0._btninsight:AddClickListener(slot0._btninsightOnClick, slot0)
	slot0._btnstyle:AddClickListener(slot0._btnstyleOnClick, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.RefreshCubeList, slot0._refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.playTalentViewBackAni, slot0._onplayBackAni, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, slot0._onUseTalentStyleReply, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.RenameTalentTemplateReply, slot0._onRenameTalentTemplateReply, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, slot0._onUseTalentTemplateReply, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.onTalentStyleRead, slot0._refreshTalentStyleRed, slot0)
	slot0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, slot0._onUseShareCode, slot0)
	slot0._dropresonategroup:AddOnValueChanged(slot0._opDropdownChange, slot0)
	slot0._btnchangetemplatename:AddClickListener(slot0._onBtnChangeTemplateName, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnchessboard:RemoveClickListener()
	slot0._btninsight:RemoveClickListener()
	slot0._btnstyle:RemoveClickListener()
	slot0._dropresonategroup:RemoveOnValueChanged()
	slot0._btnchangetemplatename:RemoveClickListener()
end

function slot0._btnchessboardOnClick(slot0)
	if slot0.rentou_ani then
		slot0.rentou_ani.enabled = true

		gohelper.setActive(slot0.rentou_ani.gameObject, true)
		slot0.rentou_ani:Play("1_3", 0, 0)
	end

	slot0._rentou_in_ani.enabled = false

	gohelper.setActive(slot0._rentou_in_ani.gameObject, false)
	slot0:_hideTalentStyle()
	slot0.view_ani:Play("charactertalentup_out")
	slot0.bg_ani:Play("ani_1_3")
	slot0.chess_ani:Play("chessboard_click")
	CharacterController.instance:openCharacterTalentChessView(slot0.hero_id)
end

function slot0._btninsightOnClick(slot0)
	if slot0.rentou_ani then
		slot0.rentou_ani.enabled = true

		gohelper.setActive(slot0.rentou_ani.gameObject, true)
		slot0.rentou_ani:Play("1_2", 0, 0)
	end

	slot0._rentou_in_ani.enabled = false

	gohelper.setActive(slot0._rentou_in_ani.gameObject, false)
	slot0:_hideTalentStyle()
	slot0.view_ani:Play("charactertalentup_out")
	slot0.bg_ani:Play("ani_1_2")
	slot0.chess_ani:Play("chessboard_out")

	if not ViewMgr.instance:isOpen(ViewName.CharacterTalentLevelUpView) or not slot0.viewParam.isBack then
		CharacterController.instance:openCharacterTalentLevelUpView({
			slot0.hero_id
		})
	end
end

function slot0._openCharacterTalentLevelUpView(slot0)
	TaskDispatcher.cancelTask(slot0._openCharacterTalentLevelUpView, slot0)
	CharacterController.instance:openCharacterTalentLevelUpView({
		slot0.hero_id
	})
end

function slot0._btnstyleOnClick(slot0)
	CharacterController.instance:openCharacterTalentStyleView({
		hero_id = slot0.hero_id
	})
end

function slot0._onUseTalentStyleReply(slot0)
	slot0:_refreshUI()
	slot0:_initTemplateList()
	slot0:_refreshStyleTag()
	slot0:_refreshMainStyleCubeItem()
	TaskDispatcher.cancelTask(slot0._hideStyleUpdateAnim, slot0)
	gohelper.setActive(slot0._styleupdate, true)
	TaskDispatcher.runDelay(slot0._hideStyleUpdateAnim, slot0, 0.6)
end

function slot0._hideStyleUpdateAnim(slot0)
	gohelper.setActive(slot0._styleupdate, false)
end

function slot0._onplayBackAni(slot0, slot1, slot2, slot3, slot4)
	if not slot2 then
		slot0.view_ani:Play("charactertalentup_in")
		slot0.chess_ani:Play("chessboard_in")
	end

	if slot3 then
		slot0.bg_ani:Play(slot3)
	end

	if slot3 == "ani_3_1" then
		slot0.chess_ani:Play("chessboard_back")
	end

	slot0._rentou_in_ani.enabled = false

	if slot0.rentou_ani then
		slot0.rentou_ani.enabled = true

		gohelper.setActive(slot0.rentou_ani.gameObject, true)
		slot0.rentou_ani:Play(slot1, 0, 0)
	end

	gohelper.setActive(slot0._rentou_in_ani.gameObject, false)

	if not slot2 then
		slot0:_showTalentStyle()
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.CharacterTalentViewAnimFinished)

	if slot4 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onReturnTalentView, slot0.hero_id)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	slot0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	slot0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	slot0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	slot0._simageglowleftdown:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_left"))
	slot0._simageglowrighttop:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_righttop"))
	slot0._simagegglowrighdown:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_rightdown"))
	slot0._simageglowmiddle:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_middle"))
	slot0._simageglow:LoadImage(ResUrl.getCharacterTalentUpTexture("shinne"))
	slot0._simageglow2:LoadImage(ResUrl.getCharacterTalentUpTexture("shinne"))
	slot0._simagecurve1:LoadImage(ResUrl.getCharacterTalentUpTexture("curve02"))
	slot0._simagecurve2:LoadImage(ResUrl.getCharacterTalentUpTexture("curve03"))
	slot0._simagecurve3:LoadImage(ResUrl.getCharacterTalentUpTexture("curve04"))
	slot0._simagequxian3:LoadImage(ResUrl.getCharacterTalentUpTexture("quxian3"))
	slot0._simagebg2:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_top"))
	slot0._simageline:LoadImage(ResUrl.getCharacterTalentUpIcon("line001"))
	slot0._simagezhigantu:LoadImage(ResUrl.getCharacterTalentUpTexture("zhigan"))

	slot0.view_ani = gohelper.findChildComponent(slot0.viewGO, "", typeof(UnityEngine.Animator))
	slot0.bg_ani = gohelper.findChildComponent(slot0.viewGO, "commen/rentouxiang/ani", typeof(UnityEngine.Animator))
	slot0.chess_ani = gohelper.findChildComponent(slot0.viewGO, "#btn_chessboard", typeof(UnityEngine.Animator))
	slot0._rentou_in_ani = gohelper.findChildComponent(slot0.viewGO, "commen/rentouxiang/ani/tou/tou_in", typeof(UnityEngine.Animator))

	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_open)
	gohelper.addUIClickAudio(slot0._btnchessboard.gameObject, AudioEnum.Talent.play_ui_resonate_property_open)
	gohelper.addUIClickAudio(slot0._btninsight.gameObject, AudioEnum.UI.play_ui_admission_open)

	slot0._animStylebtn = slot0._btnstyle.gameObject:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0._playAni(slot0, slot1, slot2)
	slot0._ani:StartPlayback()

	slot0._ani.speed = slot2 and 1 or -1

	slot0._ani:Play(slot1)
end

function slot0.onOpen(slot0)
	slot0._tou_url = "ui/viewres/character/charactertalentup/tou.prefab"
	slot0._tou_loader = MultiAbLoader.New()

	slot0._tou_loader:addPath(slot0._tou_url)
	slot0._tou_loader:startLoad(slot0._addTouPrefab, slot0)
	slot0:_refreshUI()
	CharacterController.instance:statTalentStart(slot0.hero_id)
	CharacterController.instance:dispatchEvent(CharacterEvent.CharacterTalentViewAnimFinished)
	slot0:_hideStyleUpdateAnim()
	slot0:_showTalentStyle()
end

function slot0._refreshUI(slot0)
	slot0.cell_length = 56.2
	slot0.hero_id = slot0.viewParam.heroid
	slot0.hero_mo_data = HeroModel.instance:getByHeroId(slot0.hero_id)
	slot0._mainCubeId = slot0.hero_mo_data.talentCubeInfos.own_main_cube_id

	gohelper.setActive(slot0._gotalentreddot, CharacterModel.instance:heroTalentRedPoint(slot0.hero_id))

	slot2 = {}

	for slot6, slot7 in pairs(slot0.hero_mo_data:getTalentGain()) do
		table.insert(slot2, slot7)
	end

	table.sort(slot2, function (slot0, slot1)
		return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
	end)
	gohelper.setActive(slot0._goattrEmpty, GameUtil.getTabLen(slot2) <= 0)
	gohelper.setActive(slot0._goattrContent, GameUtil.getTabLen(slot2) > 0)
	gohelper.CreateObjList(slot0, slot0._onItemShow, slot2, slot0._goattrContent, slot0._goattrItem)
	slot0:_setChessboardData()

	slot3 = HeroResonanceConfig.instance:getTalentConfig(slot0.hero_id, slot0.hero_mo_data.talent + 1) == nil
	slot0._txtinsightLv.text = not slot3 and slot0.hero_mo_data.talent or luaLang("character_max_overseas")
	slot0._txttalentcn.text = luaLang("talent_charactertalent_txt" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType])

	gohelper.setActive(slot0._goEsonan, slot0.hero_mo_data.config.heroType ~= CharacterEnum.HumanHeroType)
	gohelper.setActive(slot0._goEsoning, slot0.hero_mo_data.config.heroType == CharacterEnum.HumanHeroType)
	gohelper.setActive(slot0._golinemax, slot3)

	slot0._txtTitleStyle.text = luaLang("talent_style_title_cn_" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType])

	slot0:_initTemplateList()
	slot0:_refreshTalentStyleRed()
end

function slot0._addTouPrefab(slot0, slot1)
	if slot1:getAssetItem(slot0._tou_url) then
		if gohelper.clone(slot2:GetResource(slot0._tou_url), slot0._gotouPos, "tou") then
			gohelper.setActive(slot4, false)

			slot0.rentou_ani = slot4:GetComponent(typeof(UnityEngine.Animator))
		end

		if slot0.viewParam.isBack then
			slot0:_btninsightOnClick()
		end
	end
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot5 = slot4:Find("icon"):GetComponent(gohelper.Type_Image)
	slot6 = slot4:Find("name"):GetComponent(gohelper.Type_TextMesh)
	slot7 = slot4:Find("value"):GetComponent(gohelper.Type_TextMesh)

	if HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.key)).type ~= 1 then
		slot2.value = tonumber(string.format("%.3f", slot2.value / 10)) .. "%"
	else
		slot2.value = math.floor(slot2.value)
	end

	slot7.text = slot2.value
	slot6.text = slot8.name

	UISpriteSetMgr.instance:setCommonSprite(slot5, "icon_att_" .. slot8.id, true)
end

function slot0.getRabbetCell(slot0)
	return slot0._rabbet_cell
end

function slot0._setChessboardData(slot0)
	slot1 = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talent), ",")

	if slot0.last_talent_level ~= slot0.hero_mo_data.talent then
		slot0:_releaseCellList()

		slot0._rabbet_cell = {}
		slot0._rabbet_cell_list = {}
		slot2 = 0

		for slot6 = 0, slot1[2] - 1 do
			slot0._rabbet_cell[slot6] = {}

			for slot10 = 0, slot1[1] - 1 do
				slot11 = nil
				slot11 = (slot2 >= slot0._gomeshContainer.transform.childCount or slot0._gomeshContainer.transform:GetChild(slot2)) and gohelper.clone(slot0._gomeshItem, slot0._gomeshContainer)

				recthelper.setAnchor(slot11.transform, (slot10 - (slot1[1] - 1) / 2) * slot0.cell_length, ((slot1[2] - 1) / 2 - slot6) * slot0.cell_length)

				slot0._rabbet_cell[slot6][slot10] = ResonanceCellItem.New(slot11.gameObject, slot10, slot6, slot0)

				table.insert(slot0._rabbet_cell_list, slot0._rabbet_cell[slot6][slot10])

				slot2 = slot2 + 1
			end
		end
	end

	slot0.last_talent_level = slot0.hero_mo_data.talent
	slot0.cube_data = slot0.hero_mo_data.talentCubeInfos.data_list

	for slot5, slot6 in ipairs(slot0._rabbet_cell_list) do
		slot6.is_filled = false
	end

	slot5 = slot0.cube_data
	slot6 = slot0._gochessContainer

	gohelper.CreateObjList(slot0, slot0._onCubeItemShow, slot5, slot6, slot0._gochessitem)

	for slot5, slot6 in ipairs(slot0._rabbet_cell_list) do
		slot6:SetNormal()
	end
end

function slot0._onCubeItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot8 = gohelper.findChildImage(slot1, "cell")
	slot9 = HeroResonanceConfig.instance:getCubeMatrix(slot2.cubeId)

	UISpriteSetMgr.instance:setCharacterTalentSprite(slot4:GetComponent(gohelper.Type_Image), "ky_" .. HeroResonanceConfig.instance:getCubeConfig(slot2.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(gohelper.findChildImage(slot1, "icon"), HeroResonanceConfig.instance:getCubeConfig(slot2.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(gohelper.findChildImage(slot1, "glow"), "glow_" .. HeroResonanceConfig.instance:getCubeConfig(slot2.cubeId).icon, true)
	transformhelper.setLocalRotation(slot4, 0, 0, -slot2.direction * 90)

	slot13 = slot0.cell_length * GameUtil.getTabLen(slot9[0])
	slot14 = slot0.cell_length * GameUtil.getTabLen(slot9)
	slot15 = slot2.direction % 2 == 0

	recthelper.setAnchor(slot4, slot0._rabbet_cell[slot2.posY][slot2.posX].transform.anchoredPosition.x + (slot15 and slot13 or slot14) / 2 - slot0.cell_length / 2, slot0._rabbet_cell[slot2.posY][slot2.posX].transform.anchoredPosition.y + -(slot15 and slot14 or slot13) / 2 + slot0.cell_length / 2)

	slot16 = {}
	slot18 = GameUtil.getTabLen(slot0:_rotationMatrix(slot9, slot2.direction)[0]) - 1

	for slot22 = 0, GameUtil.getTabLen(slot10) - 1 do
		for slot26 = 0, slot18 do
			if slot10[slot22][slot26] == 1 then
				table.insert(slot16, {
					slot2.posX + slot26,
					slot2.posY + slot22
				})
			end
		end
	end

	for slot22, slot23 in ipairs(slot16) do
		slot0._rabbet_cell[slot23[2]][slot23[1]].is_filled = true

		slot0._rabbet_cell[slot23[2]][slot23[1]]:setCellData(slot2)
	end

	if slot0._mainCubeId == slot2.cubeId then
		slot0._mainCubeItem = {
			bg = slot5,
			icon = slot6,
			glow_icon = slot7,
			cell_icon = slot8,
			anim = slot8
		}

		slot0:_refreshMainStyleCubeItem()
	else
		gohelper.setActive(slot8.gameObject, false)
	end
end

function slot0._refreshMainStyleCubeItem(slot0)
	slot1 = HeroResonanceConfig.instance:getCubeConfig(slot0._mainCubeId).icon
	slot2 = "ky_" .. slot1
	slot3 = slot1
	slot4 = "glow_" .. slot1
	slot5 = string.split(slot1, "_")
	slot6 = "gz_" .. slot5[#slot5]
	slot7 = slot0.hero_mo_data:getHeroUseStyleCubeId()
	slot8 = HeroResonanceConfig.instance:getCubeConfig(slot7)

	if not (slot7 == slot0._mainCubeId) and slot8 and not string.nilorempty(slot8.icon) then
		slot2 = "ky_" .. slot10
		slot4 = "mk_" .. slot10
	end

	if slot0._mainCubeItem then
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._mainCubeItem.bg, slot2, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._mainCubeItem.icon, slot3, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._mainCubeItem.glow_icon, slot4, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._mainCubeItem.cell_icon, slot6, true)
		gohelper.setActive(slot0._mainCubeItem.cell_icon.gameObject, not slot9)
	end
end

function slot0.playChessIconOutAni(slot0)
	if slot0.cube_data then
		for slot4, slot5 in ipairs(slot0.cube_data) do
			slot0._gochessContainer.transform:GetChild(slot4 - 1):GetComponent(typeof(UnityEngine.Animator)):Play("chessitem_out")
		end
	end
end

function slot0._rotationMatrix(slot0, slot1, slot2)
	slot3 = slot1

	while slot2 > 0 do
		slot3 = {
			[slot9] = {}
		}
		slot4 = GameUtil.getTabLen(slot1)

		for slot9 = 0, GameUtil.getTabLen(slot1[0]) - 1 do
			for slot13 = 0, slot4 - 1 do
				slot3[slot9][slot13] = slot1[slot4 - slot13 - 1][slot9]
			end
		end

		if slot2 - 1 > 0 then
			slot1 = slot3
		end
	end

	return slot3
end

function slot0._releaseCellList(slot0)
	if slot0._rabbet_cell_list then
		for slot4, slot5 in ipairs(slot0._rabbet_cell_list) do
			slot5:releaseSelf()
		end

		slot0._rabbet_cell_list = nil
	end
end

function slot0._showTalentStyle(slot0)
	TalentStyleModel.instance:refreshUnlockInfo(slot0.hero_id)

	if TalentStyleModel.instance:isUnlockStyleSystem(slot0.hero_mo_data.talent) then
		slot0:_refreshStyleTag()
	end

	gohelper.setActive(slot0._gostylechange.gameObject, slot1)
	gohelper.setActive(slot0._btnstyle.gameObject, slot1)

	if slot1 then
		if slot0.hero_mo_data.isShowTalentStyleRed and TalentStyleModel.instance:isPlayStyleEnterBtnAnim(slot0.hero_id) then
			slot0._animStylebtn:Play("unlock", 0, 0)
			TalentStyleModel.instance:setPlayStyleEnterBtnAnim(slot0.hero_id)
		else
			slot0._animStylebtn:Play("open", 0, 0)
		end
	end
end

function slot0._hideTalentStyle(slot0)
end

function slot0._refreshStyleTag(slot0)
	slot2 = TalentStyleModel.instance:getTalentStyle(slot0._mainCubeId, slot0.hero_mo_data:getHeroUseCubeStyleId(slot0.hero_id))
	slot0._txtstyle.text, slot4 = slot2:getStyleTag()
	slot5, slot6 = slot2:getStyleTagIcon()

	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleslot, slot6, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleicon, slot5, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleglow, slot5, true)
end

function slot0._initTemplateList(slot0)
	table.sort(slot0.hero_mo_data.talentTemplates, CharacterTalentChessView.sortTemplate)

	slot2 = {}

	for slot7, slot8 in ipairs(slot0.hero_mo_data.talentTemplates) do
		if TalentStyleModel.instance:isUnlockStyleSystem(slot0.hero_mo_data.talent) and not string.nilorempty(TalentStyleModel.instance:getTalentStyle(slot0._mainCubeId, slot8.style) and slot10._styleCo and slot10._styleCo.tagicon) then
			slot9 = string.format("<sprite=%s>", tonumber(slot11) - 1) .. (string.nilorempty(slot8.name) and luaLang("talent_charactertalentchess_template" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType]) .. slot7 or slot8.name)
		end

		table.insert(slot2, slot9)

		if slot8.id == slot0.hero_mo_data.useTalentTemplateId then
			slot0._curSelectTemplateIndex = slot7
			slot0._txtgroupname.text = slot9
		end
	end

	slot0._dropresonategroup:ClearOptions()
	slot0._dropresonategroup:AddOptions(slot2)
	slot0._dropresonategroup:SetValue(slot0._curSelectTemplateIndex - 1)

	slot0._templateInitDone = true
end

function slot0._onBtnChangeTemplateName(slot0)
	ViewMgr.instance:openView(ViewName.CharacterTalentModifyNameView, {
		slot0.hero_mo_data.heroId,
		slot0.hero_mo_data.talentTemplates[slot0._curSelectTemplateIndex].id
	})
end

function slot0.sortTemplate(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0._opDropdownChange(slot0, slot1)
	if slot0._curSelectTemplateIndex ~= (slot1 or 0) + 1 then
		slot0._curSelectTemplateIndex = slot2

		HeroRpc.instance:UseTalentTemplateRequest(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talentTemplates[slot2].id)
	end
end

function slot0._onDropClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function slot0._onRenameTalentTemplateReply(slot0)
	slot0:_initTemplateList()
end

function slot0._onUseTalentTemplateReply(slot0)
	slot0:_showTemplateName()
	slot0:_refreshStyleTag()
	slot0:_refreshMainStyleCubeItem()
	TaskDispatcher.cancelTask(slot0._hideStyleUpdateAnim, slot0)
	gohelper.setActive(slot0._styleupdate, true)
	TaskDispatcher.runDelay(slot0._hideStyleUpdateAnim, slot0, 0.6)
	GameFacade.showToast(ToastEnum.ChangeTalentTemplate)
end

function slot0._showTemplateName(slot0)
	for slot4, slot5 in ipairs(slot0.hero_mo_data.talentTemplates) do
		if slot5.id == slot0.hero_mo_data.useTalentTemplateId then
			if not string.nilorempty(TalentStyleModel.instance:getTalentStyle(slot0._mainCubeId, slot5.style) and slot8._styleCo and slot8._styleCo.tagicon) then
				slot7 = string.format("<sprite=%s>", tonumber(slot9) - 1) .. (string.nilorempty(slot5.name) and luaLang("talent_charactertalentchess_template" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType]) .. slot0._curSelectTemplateIndex or slot5.name)
			end

			slot0._txtgroupname.text = slot7
		end
	end
end

function slot0._refreshTalentStyleRed(slot0)
	gohelper.setActive(slot0._goStyleRed, slot0.hero_mo_data.isShowTalentStyleRed)
end

function slot0._onUseShareCode(slot0, slot1)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	if slot0._tou_loader then
		slot0._tou_loader:dispose()
	end

	slot0:_releaseCellList()
	TaskDispatcher.cancelTask(slot0._openCharacterTalentLevelUpView, slot0)
	CharacterController.instance:statTalentEnd(slot0.hero_id)
	TaskDispatcher.cancelTask(slot0._hideStyleUpdateAnim, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
	slot0._simagerighticon2:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simageglowleftdown:UnLoadImage()
	slot0._simageglowrighttop:UnLoadImage()
	slot0._simagegglowrighdown:UnLoadImage()
	slot0._simageglowmiddle:UnLoadImage()
	slot0._simageglow:UnLoadImage()
	slot0._simageglow2:UnLoadImage()
	slot0._simagecurve1:UnLoadImage()
	slot0._simagecurve2:UnLoadImage()
	slot0._simagecurve3:UnLoadImage()
	slot0._simagequxian3:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagezhigantu:UnLoadImage()
end

return slot0
