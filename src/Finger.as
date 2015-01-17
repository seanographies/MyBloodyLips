package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Finger extends Entity 
	{
		protected var _spritemap:Spritemap = new Spritemap(GA.FINGER_SPRITES, 128, 128);
		protected var _spritemapf:Spritemap = new Spritemap(GA.FINGER_SPRITES, 128, 128);
		protected var _spritemapr:Spritemap = new Spritemap(GA.FINGER_SPRITES, 128, 128);
		protected var glist:Graphiclist = new Graphiclist;
		
		protected var gm:GameManager = new GameManager();
		
		public var _pressed:Number = 0;
		
		protected var health:Number;
		
		protected var thoughts:Thoughts = new Thoughts();
		protected var _pullHand:Boolean = false;
		
		protected var mouth:Mouth = new Mouth();
		
		protected var controlsEnable:Boolean = true;
		protected var firstBite:Boolean = false;
		
		protected var bite_sfx:Sfx = new Sfx(GA.BITE_SFX);
		protected var lick_sfx:Sfx = new Sfx(GA.LICK_SFX);
		
		public function Finger() 
		{
			this.x = 100;
			this.y = 200;
			
			setHitbox(128, 128, 64, 64);
			
			addFingerSprites();
			addDamageSprites();
			addRegenSprites();
			
			initHealth();
			
			handleFinger();
			handleRegenFinger();
			handleDamageFinger();
			
			createThoughts();
			
			graphic = glist;
			
			if (GameManager.SceneTicket ==0) {
				FP.world.remove(this);
			}
			
			layer = GC.BEHIND_MIRROR;
			type = "finger";
			
			FP.world.add(mouth);
		}
		
		override public function update():void 
		{
			super.update();
			updateControls();
			handleBiting();
			handleLicking();
			updateParameters();
		}
		
		protected function addFingerSprites():void {
			_spritemapf.add("thumb", [0], 0, false);
			_spritemapf.add("index", [4], 0, false);
			_spritemapf.add("middle", [8], 0, false);
			_spritemapf.add("ring", [12], 0, false);
			_spritemapf.add("pinkie", [16], 0, false);
			
			_spritemapf.centerOO();
			_spritemapf.scale = 2.5;
			_spritemapf.angle = 30;
		}
		
		protected function addDamageSprites():void {
			_spritemap.add("thumb2", [1], 0, false);
			_spritemap.add("thumb1", [2], 0, false);
			_spritemap.add("thumb0", [3], 0, false);
			
			_spritemap.add("index2", [5], 0, false);
			_spritemap.add("index1", [6], 0, false);
			_spritemap.add("index0", [7], 0, false);
			
			_spritemap.add("middle2", [9], 0, false);
			_spritemap.add("middle1", [10], 0, false);
			_spritemap.add("middle0", [11], 0, false);
			
			_spritemap.add("ring2", [13], 0, false);
			_spritemap.add("ring1", [14], 0, false);
			_spritemap.add("ring0", [15], 0, false);
			
			_spritemap.add("pinkie2", [17], 0, false);
			_spritemap.add("pinkie1", [18], 0, false);
			_spritemap.add("pinkie0", [19], 0, false);
			
			_spritemap.centerOO();
			_spritemap.scale = 2.5;
			_spritemap.angle = 30;
		}
		
		protected function addRegenSprites():void {
			_spritemapr.add("t1", [20], 0, false);
			_spritemapr.add("t2", [21], 0, false);
			_spritemapr.add("t3", [22], 0, false);
			
			_spritemapr.add("i1", [23], 0, false);
			_spritemapr.add("i2", [24], 0, false);
			_spritemapr.add("i3", [25], 0, false);
			
			_spritemapr.add("m1", [26], 0, false);
			_spritemapr.add("m2", [27], 0, false);
			_spritemapr.add("m3", [28], 0, false);
			
			_spritemapr.add("r1", [29], 0, false);
			_spritemapr.add("r2", [30], 0, false);
			_spritemapr.add("r3", [31], 0, false);
			
			_spritemapr.add("p1", [32], 0, false);
			_spritemapr.add("p2", [33], 0, false);
			_spritemapr.add("p3", [34], 0, false);
			
			_spritemapr.centerOO();
			_spritemapr.scale = 2.5;
			_spritemapr.angle = 30;
		}
		
		//parameters for each finger
		protected function updateParameters():void {
			if (GameManager.Solution == 1) {
				if (this.y < 152) {
					this.y = 152;
				}
			}			
			
			if (GameManager.Solution == 2) {
				if (this.y < 200) {
					this.y = 200;
				}
			}			
			
			if (GameManager.Solution == 3) {
				if (this.y < 160) {
					this.y = 160;
				}
			}			
			
			if (GameManager.Solution == 4) {
				if (this.y < 120) {
					this.y = 120;
				}
			}			
			
			if (GameManager.Solution == 5) {
				if (this.y < 80) {
					this.y = 80;
				}
			}
		}
		
		//updates controls for mouse with finger
		protected function updateControls():void {
			Mouse.hide();
			if (controlsEnable) {
				this.x = Input.mouseX;
				this.y = Input.mouseY;
				//TODO: set parameters for finger based on mirror
				if (x > 400 || x< 400) {
					x = 400;
				}
				if ( y > 300) {
					y = 300;
				}
				if (y < 70) {
					y = 70;
				}
			}
		}
		
		//handles the collisions with mouth and incr the thoughts var/plays biting sprite
		protected function handleBiting():void {
			var counter:Number;
			
			if (GameManager.SceneTicket == 1) {
				if (collide("mouth", x, y)) {
						if (health < 1) {
							removeFinger();
						}		
					if (Input.mouseReleased && health > 0) {
						firstBite = true;
						bite_sfx.play();
						GameManager.Bites++;
						mouth.playBite();
						GameManager.Thoughts++;
						createThoughts();
						handleDamageFinger();
						_pullHand = true;
					}
				}
				if (this.y >= 250 && _pullHand) {
						removeFinger();
						_pullHand = false;
				}	
			}
		}
		
		// handles the licking the pull back to return and pick another finger, licking + 1 health to licked finger
		protected function handleLicking():void {
			var  _pressed_limit:Number = Math.floor(Math.random() * 10) +  250;
				if (collide("mouth", x, y)) {
					if (Input.mouseDown && firstBite) {
						//trace("LICK");
						_pressed++;
						if (_pressed == 70) {
							lick_sfx.play();
							}
						if (_pressed == 150) {
								lick_sfx.play();
							}
							if (_pressed >= 70) {
								mouth.playLicking();
								controlsEnable = false;
							}
							if (_pressed >= _pressed_limit) {
								if (GameManager.Problem !== 3) {
								GameManager.Problem ++;
								}else {
									GameManager.Problem = 1;
								}
								controlsEnable = true;
								firstBite = false;
								gm.changeProblem();
								health += 1;
								handleDamageFinger();
								_pressed = 0;
								removeFinger();
							}
						}
					}
		}			
		
		//creates thoughts based on problem,solution and number of thought hits, calls next scene after last thought
		protected function createThoughts():void {				
			if ( GameManager.Problem == 0) {
					if (GameManager.Solution == 1) {
						trace("thoughts for solution 1, hit: " + GameManager.Thoughts)
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("It's you.Maybe it is because I have hurt you before and you show you want some more.", 1, 0);
								break;
							case 1:
								addThoughts("So I peel off that beautiful layer that protects you.", 0, 0);
								break;
							case 2:
								addThoughts("When the flesh is revealed then it will release me from this pain.", 0, 0);
								break;							
							case 3:
								addThoughts("The blood on my lips are a trace of how much I need you. How much I love you.", 0, 0);
								break;							
							case 4:
								addThoughts("I lick the blood off my lips if I'm satisfied or...", 0, 0);
								break;							
							case 5:
								addThoughts("else,make it raw again or pull you away from my face for another", 1, 0);
								break;							
							case 6:
								addThoughts("", 1, 0);
								break;
							default:
								break;
						}
					}								
					if (GameManager.Solution == 2) {
						trace("thoughts for solution 2")
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("The dead skin around your nail agitates me", 1, 0);
								break;
							case 1:
								addThoughts("I need to pick it", 0, 0);
								break;
							case 2:
								addThoughts("I don't need it to remind me of all the pain i've felt", 0, 0);
								break;							
							case 3:
								addThoughts("It needs to be born again", 0, 0);
								break;							
							case 4:
								addThoughts("I lick the blood off my lips if I'm satisfied or...", 0, 0);
								break;							
							case 5:
								addThoughts("else,make it raw again or pull you away from my face for another", 1, 0);
								break;							
							case 6:
								addThoughts("", 1, 0);
								break;
							default:
								break;
						}
					}					
					if (GameManager.Solution == 3) {
						trace("thoughts for solution 3")
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("Its almost involuntary", 1, 0);
								break;
							case 1:
								addThoughts("It's you, you're the one who always asks for it", 0, 0);
								break;
							case 2:
								addThoughts("Its only your blood which soothes me, your flesh which burns me", 0, 0);
								break;							
							case 3:
								addThoughts("This is the only way I can get rid of this ache", 0, 0);
								break;							
							case 4:
								addThoughts("I lick the blood off my lips if I'm satisfied or...", 0, 0);
								break;							
							case 5:
								addThoughts("else,make it raw again or pull you away from my face for another", 1, 0);
								break;							
							case 6:
								addThoughts("", 1, 0);
								break;
							default:
								break;
						}
					}					
					if (GameManager.Solution == 4) {
						trace("thoughts for solution 4")
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("You're fully recovered, not a speck of loose dead skin to be picked", 1, 0);
								break;
							case 1:
								addThoughts("I don't like this, how? All this while I have never picked you?", 0, 0);
								break;
							case 2:
								addThoughts("Now you  can be like all the rest.", 0, 0);
								break;							
							case 3:
								addThoughts("Your blood is so fresh and pure", 0, 0);
								break;							
							case 4:
								addThoughts("I lick the blood off my lips if I'm satisfied or...", 0, 0);
								break;							
							case 5:
								addThoughts("else,make it raw again or pull you away from my face for another", 1, 0);
								break;							
							case 6:
								addThoughts("", 1, 0);
								break;
							default:
								break;
						}
					}
					if (GameManager.Solution == 5) {
						trace("thoughts for solution 5")
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("You're the toughest", 1, 0);
								break;
							case 1:
								addThoughts("You're my one reliable finger", 0, 0);
								break;
							case 2:
								addThoughts("You're always so discreet, so satisfying you steal me away from reality.", 0, 0);
								break;							
							case 3:
								addThoughts("You pull it all together, so tightly you knit me back up and I'm ready to go away.", 0, 0);
								break;							
							case 4:
								addThoughts("I lick the blood off my lips if I'm satisfied or...", 0, 0);
								break;							
							case 5:
								addThoughts("else,make it raw again or pull you away from my face for another", 1, 0);
								break;							
							case 6:
								addThoughts("", 1, 0);
								break;
							default:
								break;
						}
					}
			}				
			
			if ( GameManager.Problem == 1) {
					if (GameManager.Solution == 1) {
						trace("thoughts for solution 1, hit: " + GameManager.Thoughts)
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("Messy Hair, fat face, brown skin", 1, 1);
								break;
							case 2:
								addThoughts("You saw me when you were over taking me in X-Country, I was panting on the verge of choking on my own tongue.", 1, 0);
								break;
							case 3:
								addThoughts("", 1, 1);
								//last thought must be a blank
							default:
								break;
						}
					}								
					if (GameManager.Solution == 2) {
						trace("thoughts for solution 2")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("I'm oblivious to who I am", 1, 0);
								break
							case 2:
								addThoughts("The way I see myself is only through glasses tinted with my failures", 0, 1);
								break;								
							case 3:
								addThoughts("Maybe I'm kind?", 0, 0);
								break;
							case 4:
								addThoughts("No, I dont think so, with the volume of my mum shouting at me from the living room.", 1, 1);
								break;							
							case 5:
								addThoughts("", 1, 0);
								break;
						}
					}					
					if (GameManager.Solution == 3) {
						trace("thoughts for solution 3")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("It can't be.", 1, 0);
								break
							case 2:
								addThoughts("I saw her, she's always looking at me from across the room. It cant be that I'm the hunch back of Notre Dame.", 1, 1);
								break;								
							case 3:
								addThoughts("My long fringe is playing tricks on me.", 0, 0);
								break;								
							case 4:
								addThoughts("But it does not matter. My love isn't mutual.", 0, 1);
								break;									
							case 5:
								addThoughts("Its just this trickled down heavily diluted solution imagined from what society expects of me.", 0, 0);
								break;								
							case 6:
								addThoughts("", 1, 0);
								break;		
						}
					}					
					if (GameManager.Solution == 4) {
						trace("thoughts for solution 4")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("Is it possible that I have convinced myself that she has fallen in love with me through my daydreams?", 1, 0);
								break
							case 2:
								addThoughts("My sexual frustration has escalated up to the point where a cute girl I like receives and sends", 0, 1);
								break;								
							case 3:
								addThoughts("Only to have me head down and turned inside out to figure out why", 1, 1);
								break;								
							case 4:
								addThoughts("", 1, 0);
								break;		
						}
					}
					if (GameManager.Solution == 5) {
						trace("thoughts for solution 5")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("Who cares, its school.", 1, 0);
								break
							case 2:
								addThoughts("My worth isn't based on the fact that I failed maths", 0, 1);
								break;								
							case 3:
								addThoughts("Maybe I should do what I want during school because after, I'm going to fail at life and be homeless.", 1, 0);
								break;									
							case 4:
								addThoughts("Love will not exist then.", 0, 0);
								break;								
							case 5:
								addThoughts("", 1, 0);
								break;		
						}
				}
			}	
			
			if ( GameManager.Problem == 2) {
					if (GameManager.Solution == 1) {
						trace("thoughts for solution one")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("My intelligence is slowly deteriorating, when I read words I see the letters and they dont make sense.", 1, 1);
								break
							case 2:
								addThoughts("Each letter, a symbol misinterpreted by our language", 0, 0);
								break;								
							case 3:
								addThoughts("Maybe this is a disorder", 1, 1);
								break;									
								case 4:
								addThoughts("", 1, 0);
								break;		
						}
					}								
					if (GameManager.Solution == 2) {
						trace("thoughts for solution 2")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("I cant concentrate", 1, 0);
								break
							case 2:
								addThoughts("I take things in and absorb them slowly as it goes along the conveyor belt reaching the other section beyond my reach before I can grasp it.", 0, 1);
								break;								
							case 3:
								addThoughts("Breathe in, Breathe out. Zone in, sometimes time is a terrible thing that makes me take for granted the finer details of art.", 0, 1);
								break;								
							case 4:
								addThoughts("I need to understand that I can't do everything and the things that I do, I need to invest effort and listen to its heart beat, feel it's breath, breathing down on my neck.", 1, 0);
								break;							
							case 5:
								addThoughts("", 1, 0);
								break;
						}
					}					
					if (GameManager.Solution == 3) {
						trace("thoughts for solution 3")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("It always seems that living a normal life isn't normal at all. ", 1, 1);
								break
							case 2:
								addThoughts("That you need to be someone or something to take control of your life", 0, 0);
								break;								
							case 3:
								addThoughts("That you can never be satisfied if your just a nobody", 0, 0);
								break;									
							case 4:
								addThoughts("Why is there no value in living a normal life without owing some fucking bigot a living.", 1, 1);
								break;									
							case 5:
								addThoughts("", 1, 0);
								break;		
						}
					}					
					if (GameManager.Solution == 4) {
						trace("thoughts for solution 4")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("Everyone seems to know something which I don't. ", 1, 0);
								break
							case 2:
								addThoughts("When I see other people converse and hang out in public I feel like i missed something.", 0, 1);
								break;								
							case 3:
								addThoughts("Was there a mandatory class in primary school that taught you how to socialize and make friends?", 1, 0);
								break;									
							case 4:
								addThoughts("I must have fallen sick on that day.", 0, 1);
								break;									
							case 5:
								addThoughts("Its like a secret network that you only get invited to if you conform to society and the expectations of what it means to be an adult", 0, 0);
								break;								
							case 6:
								addThoughts("", 1, 0);
								break;		
						}
					}
					if (GameManager.Solution == 5) {
						trace("thoughts for solution 5")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("It's the backbone of everything I dream of.", 1, 0);
								break
							case 2:
								addThoughts("Its the avenging of the unemployment that made him miserable. His lost dreams and hopes are passed onto me.", 0, 1);
								break;								
							case 3:
								addThoughts("Is it immoral to be motivated by the guilt of owing something to your parents of having to become somebody.", 0, 0);
								break;								
							case 4:
								addThoughts("Society, they judge you on your status on how educated you are, where you worked, who the fuck you were friends with and who you begged and pleaded with for an opportunity.", 1, 0);
								break;													
							case 5:
								addThoughts("I want something real.", 0, 1);
								break;									
							case 6:
								addThoughts("", 1, 0);
								break;		
						}
					}
				}	
			
			if ( GameManager.Problem == 3) {
					if (GameManager.Solution == 1) {
						trace("thoughts for solution one")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("Mum used to have this, she said she used to do it when she was younger, but she's stopped.", 1, 1);
								break
							case 2:
								addThoughts("How did she stop just like that. Maybe it was because she had me.", 1, 0);
								break;								
							case 3:
								addThoughts("She had to be a role model to her child. Not show weakness.", 0, 0);
								break;									
							case 4:
								addThoughts("", 1, 1);
								break;		
						}
					}								
					if (GameManager.Solution == 2) {
						trace("thoughts for solution 2")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("This is an addiction", 1, 1);
								break
							case 2:
								addThoughts("I will live with it through my whole life, I dont give a fuck.", 0, 0);
								break;								
							case 3:
								addThoughts("It hurts, but it feels good. It calms my hot skin and prickly standing hairs when I know she's around.", 1, 1);
								break;								
							case 4:
								addThoughts("This is an ideology", 0, 0);
								break;									
							case 5:
								addThoughts("I peel off the  facade that we are told to believe, it bleeds out the truth and I lick it, absorbing all that is wrong and dig deeper to root and expose it to the sunlight that kills it.", 0, 0);
								break;									
							case 6:
								addThoughts("", 1, 0);
								break;		
						}
					}					
					if (GameManager.Solution == 3) {
						trace("thoughts for solution 3")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts(' "Oh, I just cut myself. I dont know how it happened, its just cuts." ', 1, 1);
								break
							case 2:
								addThoughts(' "Its alright theres nothing wrong, it doesnt hurt." ', 0, 0);
								break;								
							case 3:
								addThoughts("When they walk away I trim it and lick all the blood up. Its recycling.", 1, 1);
								break;								
							case 4:
								addThoughts(' "Youre disgusted by blood? The fluid that gives you life, protects you, youre fucked up for feeling that. Fuck you." ', 0, 0);
								break;									
							case 5:
								addThoughts('', 1, 0);
								break;		
						}
					}					
					if (GameManager.Solution == 4) {
						trace("thoughts for solution 4")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("There was a youtube video, the girl in it was talking about it.", 1, 1);
								break
							case 2:
								addThoughts("Just her face, staring into the camera, it was intimate. She has never told anyone before.", 0, 0);
								break;								
							case 3:
								addThoughts('She brought up her fingers to the camera, "its called Dermatophagia" ', 1, 0);
								break;							
							case 4:
								addThoughts('Im not the only one, shes afraid of it, shes a ashamed of it. ', 0, 0);
								break;									
							case 5:
								addThoughts("She says she hides her fingers when others talk to her. She's hiding the scars and anxieties that they inflicted. ", 0, 1);
								break;									
							case 6:
								addThoughts("", 1, 0);
								break;								}
					}
					if (GameManager.Solution == 5) {
						trace("thoughts for solution 5")
						switch (GameManager.Thoughts) {
							case 1:
								addThoughts("It starts with the abuse of the skin around the nails, its the easiest to peel.", 1, 0);
								break
							case 2:
								addThoughts("Then it moves to the knuckles, then the face", 0, 0);
								break;								
							case 3:
								addThoughts("Eventually, how long will it take me to realize that abusing myself isn't enough and I stretch out to other horizons.", 1, 1);
								break;							
							case 4:
								addThoughts("Substances, people. Then once it gets out of control maybe I'll realize that I never wanted to hurt anybody, not even myself, the foreign skin around my nails.", 0, 1);
								break;								
							case 5:
								addThoughts("", 1, 0);
								break;		
						}
					}
				}			
			
			if ( GameManager.Problem == 4) {
					if (GameManager.Solution == 1) {
						trace("thoughts for solution one")
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("I just try to accept them", 0, 1);
								break
							case 1:
								addThoughts("Because I know that I can never solve them",0, 1);
								break;																
							case 2:
								addThoughts("", 1, 2);
								break;									
							case 3:
								addThoughts("", 1, 0);
								break;								
							case 4:
								addThoughts("", 1, 0);
								break;		
						}
					}								
					if (GameManager.Solution == 2) {
						trace("thoughts for solution 2")
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("I have to solve my problems", 0, 1);
								break
							case 1:
								addThoughts("Instead of running away with sore fingers and bloody lips",0, 1);
								break;																
							case 2:
								addThoughts("", 1, 2);
								break;									
							case 3:
								addThoughts("", 1, 0);
								break;								
							case 4:
								addThoughts("", 1, 0);
								break;		
						}
					}					
					if (GameManager.Solution == 3) {
						trace("thoughts for solution 3")
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("It will only be a matter of time till I begin this ritual again", 0, 1);
								break
							case 1:
								addThoughts("The curtains will draw back, then I will know that it is time",0, 1);
								break;																
							case 2:
								addThoughts("", 1, 2);
								break;									
							case 3:
								addThoughts("", 1, 0);
								break;								
							case 4:
								addThoughts("", 1, 0);
								break;		
						}
					}					
					if (GameManager.Solution == 4) {
						trace("thoughts for solution 4")
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("I feel so sorry for them, having problems taunt them in their heads. They must get no release.", 0, 1);
								break
							case 1:
								addThoughts("How do they escape without bloodied lips and skinless fingers?",0, 1);
								break;																
							case 2:
								addThoughts("", 1, 2);
								break;									
							case 3:
								addThoughts("", 1, 0);
								break;								
							case 4:
								addThoughts("", 1, 0);
								break;		
						}
					}
					if (GameManager.Solution == 5) {
						trace("thoughts for solution 5")
						switch (GameManager.Thoughts) {
							case 0:
								addThoughts("Something else. Im sure it's much more effective and less ashamed.", 0, 1);
								break
							case 1:
								addThoughts("Is it an ego, is it greed, is it money?",0, 1);
								break;																
							case 2:
								addThoughts("", 1, 2);
								break;									
							case 3:
								addThoughts("", 1, 0);
								break;								
							case 4:
								addThoughts("", 1, 0);
								break;		
						}
					}
				}	
		}
		
		//creates text for thoughts as well as determines var which -- anxiety, to activate last line(which is lick or to pull down, a finger cant have thoughts that inflict more than 2 damage)
		protected function addThoughts( _text:String, _damage:Number, _anxiety:Number):void {
			thoughts.setText(_text);
			FP.world.add(thoughts);
			health -= _damage;
			GameManager.Anxiety -= _anxiety;
		}
		
		//called after licking scene to return back to scene 0
		protected function removeFinger():void {
			lick_sfx.stop();
			bite_sfx.stop();
			GameManager.stopMusic = true;
			_pressed = 0;
			GameManager.SceneTicket = 0;
			gm.changeScene();
			GameManager.SceneOneEnd = false;
			GameManager.Thoughts = 0;
			trace("Anxiety is " + GameManager.Anxiety);
			FP.world.remove(this);
			FP.world.remove(thoughts);
		}
		
		//creates the first instance of health for the fingers
		protected function initHealth():void {
			switch(GameManager.Solution) {
				case 1:
					health = GameManager.Thumb_Health;
					break;				
				case 2:
					health = GameManager.Index_Health;
					break;
				case 3:
					health = GameManager.Middle_Health;
					break;
				case 4:
					health = GameManager.Ring_Health;
					break;
				case 5:
					health = GameManager.Pinkie_Health;
					break;
			}
		}
		
		//displays the sprite for the corresponding solution
		protected function handleFinger():void {
			switch(GameManager.Solution) {
				case 1:
					_spritemapf.play("thumb");
					setHitbox(128, 128, 64, 64);
						_spritemapf.x = 25;
					break;
				case 2:
					_spritemapf.play("index");
					setHitbox(128, 128, 64, 92);
						_spritemapf.x = -30;
					break;
				case 3:
					_spritemapf.play("middle");
					setHitbox(128, 128, 64, 48);
					_spritemapf.x = -60;
					break;
				case 4:
					_spritemapf.play("ring");
					setHitbox(128, 128, 64, 8);
					_spritemapf.x = -80;
					break;
				case 5:
					_spritemapf.play("pinkie");
					setHitbox(128, 128, 64, -12);
					_spritemapf.x = -110;
					break;
			}
			glist.add(_spritemapf);
		}
		
		//handles the fingers; sprites,health,updates the fingers sprite according to health and updates health.
		protected function handleDamageFinger():void {
			if (health == 0) {
				switch(GameManager.Solution) {
					case 1:
						_spritemap.play("thumb0");
						_spritemap.x = 25;
						GameManager.Thumb_Health = health;
						trace("Thumb health is " + GameManager.Thumb_Health);
						break;
					case 2:
						_spritemap.play("index0");
						_spritemap.x = -30;
						GameManager.Index_Health = health;
						trace("Index health is " + GameManager.Index_Health);
						break;
					case 3:
						_spritemap.play("middle0");
						_spritemap.x = -60;
						GameManager.Middle_Health = health;
						trace("Middle health is " + GameManager.Middle_Health);
						break;
					case 4:
						_spritemap.play("ring0");
						_spritemap.x = -80;
						GameManager.Ring_Health = health;
						trace("Ring health is " + GameManager.Ring_Health);
						break;
					case 5:
						_spritemap.play("pinkie0");
						_spritemap.x = -110;
						GameManager.Pinkie_Health = health;
						trace("Pinkie health is " + GameManager.Pinkie_Health);
						break;
				}
				glist.add(_spritemap);
			}
			
			if (health == 2) {
				switch(GameManager.Solution) {
					case 1:
						_spritemap.play("thumb2");
						_spritemap.x = 25;
						GameManager.Thumb_Health = health;
						trace("Thumb health is " + GameManager.Thumb_Health);
						break;
					case 2:
						_spritemap.play("index2");
						_spritemap.x = -30;
						GameManager.Index_Health = health;
						trace("Index health is " + GameManager.Index_Health);
						break;
					case 3:
						_spritemap.play("middle2");
						_spritemap.x = -60;
						GameManager.Middle_Health = health;
						trace("Middle health is " + GameManager.Middle_Health);
						break;
					case 4:
						_spritemap.play("ring2");
						_spritemap.x = -80;
						GameManager.Ring_Health = health;
						trace("Ring health is " + GameManager.Ring_Health);
						break;
					case 5:
						_spritemap.play("pinkie2");
						_spritemap.x = -110;
						GameManager.Pinkie_Health = health;
						trace("Pinkie health is " + GameManager.Pinkie_Health);
						break;
				}
				glist.add(_spritemap);
			}
			
			if (health == 1) {
				switch(GameManager.Solution) {
					case 1:
						_spritemap.play("thumb1");
						_spritemap.x = 25;
						GameManager.Thumb_Health = health;
						trace("Thumb health is " + GameManager.Thumb_Health);
						break;
					case 2:
						_spritemap.play("index1");
						_spritemap.x = -30;
						GameManager.Index_Health = health;
						trace("Index health is " + GameManager.Index_Health);
						break;
					case 3:
						_spritemap.play("middle1");
						_spritemap.x = -60;
						GameManager.Middle_Health = health;
						trace("Middle health is " + GameManager.Middle_Health);
						break;
					case 4:
						_spritemap.play("ring1");
						_spritemap.x = -80;
						GameManager.Ring_Health = health;
						trace("Ring health is " + GameManager.Ring_Health);
						break;
					case 5:
						_spritemap.play("pinkie1");
						_spritemap.x = -110;
						GameManager.Pinkie_Health = health;
						trace("Pinkie health is " + GameManager.Pinkie_Health);
						break;
				}
				glist.add(_spritemap);
			}
		}
		
		//handles the flesh sprites for the corresponding finger
		protected function handleRegenFinger():void {
			if (GameManager.Solution == 1) {
				switch(GameManager.Thumb_Recover) {
					case 1:
						_spritemapr.play("t1");
						glist.add(_spritemapr);
						break;
					case 2:
						_spritemapr.play("t2");
						glist.add(_spritemapr);
						break;
					case 3:
						_spritemapr.play("t3");
						glist.add(_spritemapr);
						break;
				}
				_spritemapr.x = 25;
			}			
			
			if (GameManager.Solution == 2) {
				switch(GameManager.Index_Recover) {
					case 1:
						_spritemapr.play("i1");
						glist.add(_spritemapr);
						break;
					case 2:
						_spritemapr.play("i2");
						glist.add(_spritemapr);
						break;
					case 3:
						_spritemapr.play("i3");
						glist.add(_spritemapr);
						break;
				}
				_spritemapr.x = -30;
			}			
			
			if (GameManager.Solution == 3) {
				switch(GameManager.Middle_Recover) {
					case 1:
						_spritemapr.play("m1");
						glist.add(_spritemapr);
						break;
					case 2:
						_spritemapr.play("m2");
						glist.add(_spritemapr);
						break;
					case 3:
						_spritemapr.play("m3");
						glist.add(_spritemapr);
						break;
				}
				_spritemapr.x = -60;
			}			
			
			if (GameManager.Solution == 4) {
				switch(GameManager.Ring_Recover) {
					case 1:
						_spritemapr.play("r1");
						glist.add(_spritemapr);
						break;
					case 2:
						_spritemapr.play("r2");
						glist.add(_spritemapr);
						break;
					case 3:
						_spritemapr.play("r3");
						glist.add(_spritemapr);
						break;
				}
				_spritemapr.x = -80;
			}			
			
			if (GameManager.Solution == 5) {
				switch(GameManager.Pinkie_Recover) {
					case 1:
						_spritemapr.play("p3");
						glist.add(_spritemapr);
						break;
					case 2:
						_spritemapr.play("p3");
						glist.add(_spritemapr);
						break;
					case 3:
						_spritemapr.play("p3");
						glist.add(_spritemapr);
						break;
				}
				_spritemapr.x = -110;
			}
		}
		
	}

}