module("modules.logic.bossrush.view.BossRushDefine", package.seeall)

return {
	init = function(arg_1_0)
		arg_1_0.V2a9_BossRushHeroGroupFightView = {
			bgBlur = 4,
			container = "V2a9_BossRushHeroGroupFightViewContainer",
			destroy = 0,
			mainRes = "ui/viewres/sp01/assassin2/v2a9_herogroupview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Normal,
			anim = ViewAnim.Internal,
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				},
				{
					{
						CurrencyView.prefabPath
					}
				}
			},
			otherRes = {
				[1] = "ui/viewres/fight/clothskill.prefab",
				[2] = "ui/viewres/sp01/assassin2/v2a9_herogroupskillview.prefab"
			}
		}
		arg_1_0.V2a9_BossRushSkillBackpackView = {
			destroy = 0,
			container = "V2a9_BossRushSkillBackpackViewContainer",
			mainRes = "ui/viewres/sp01/assassin2/assassinbackpackview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Full,
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				}
			}
		}
	end
}
