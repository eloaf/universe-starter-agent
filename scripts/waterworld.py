from ple.games.waterworld import WaterWorld as PyGameWaterWorld
from ple import PLE
import numpy as np
from gym import spaces


class WaterWorld:

    def __init__(self, fps=30, display_screen=False):
        game = PyGameWaterWorld()
        self.game = PLE(game, fps=fps, display_screen=display_screen)
        action_set = self.game.getActionSet()
        self.action_map = {i: a for (i, a) in enumerate(action_set)}
        self.action_space = spaces.Discrete(len(self.action_map))
        self.metadata = {'render.modes': ['human', 'rgb_array']}

        box = np.ones((48, 48, 3), dtype='float32')
        self.observation_space = spaces.Box(low=box * 0, high=box * 255)

    def reset(self):
        self.game.reset_game()
        return self.game.getScreenRGB()

    def step(self, action):
        a = self.action_map[action]
        r = self.game.act(a)
        done = self.game.game_over()
        info = {}
        return self.game.getScreenRGB(), r, done, info

    def close(self):
        pass

if __name__ == "__main__":
    env = WaterWorld()
    env.reset()


    import pdb; pdb.set_trace()

    for it in range(3):
        print('Playing iteration %s' % it)
        done = False
        o = env.reset()
        R = 0
        while not done:
            a = np.random.choice(env.action_set)
            o, r, done, _ = env.step(a)
            R += r
            #print(a, o.min(), o.max(), r, done)
        print('...Done, final reward=', R)
