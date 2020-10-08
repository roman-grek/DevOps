using System;
using System.Security.Cryptography;

namespace RockPaperScissors
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            if (args.Length % 2 == 0 || args.Length < 3)
            {
                Console.WriteLine("Invalid arguments (must be odd number of args >=3)");
                return;
            }
            
            var computerMove = new Random().Next(args.Length);
            var randomKey = new byte[256];
            var rng = new RNGCryptoServiceProvider();
            rng.GetBytes(randomKey);
            Console.WriteLine(GenerateHmacString(randomKey, computerMove));

            int playerMove;
            while (true)
            {
                Console.WriteLine("Available moves:");
                for (var i = 0; i < args.Length; i++)
                    Console.WriteLine($"{i + 1} - {args[i]}");
                Console.WriteLine("0 - exit");
                Console.Write("Enter your move: ");
                var playerInput = Console.ReadLine();
                if (!Int32.TryParse(playerInput, out playerMove)) continue;
                if (playerMove == 0) return;
                if (playerMove > args.Length || playerMove < 1) continue;
                playerMove--;
                break;
            }
            
            Console.WriteLine($"Your move: {args[playerMove]}");
            Console.WriteLine($"Computer move: {args[computerMove]}");
            if (playerMove == computerMove)
                Console.WriteLine("Draw");
            else if (WinAgainst(playerMove, computerMove, args.Length))
                Console.WriteLine( "You win!");
            else
                Console.WriteLine("You lose!");
            Console.WriteLine("HMAC key: " + BitConverter.ToString(randomKey).Replace("-", ""));
        }

        private static bool WinAgainst(int playerMove, int computerMove, int movesCount)
        {
            var middle = movesCount / 2 + 1 + playerMove;
            var extendedMoves = new int[movesCount * 2];
            for (var i = 0; i < movesCount; i++)
                extendedMoves[i] = extendedMoves[i + movesCount] = i;
            for (var i = playerMove; i < middle; i++)
                if (extendedMoves[i] == computerMove)
                    return false;
            return true;
        }

        private static string GenerateHmacString(byte[] key, int computerMove)
        {
            var hmac = new HMACSHA256(key);
            var hashValue = hmac.ComputeHash(BitConverter.GetBytes(computerMove));
            return "HMAC: " + BitConverter.ToString(hashValue).Replace("-", "");
        }
    }
}