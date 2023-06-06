-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 06, 2023 at 05:48 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `theautoadvise`
--

-- --------------------------------------------------------

--
-- Table structure for table `about_autoadvice`
--

CREATE TABLE `about_autoadvice` (
  `sno` int(11) NOT NULL,
  `about` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `about_autoadvice`
--

INSERT INTO `about_autoadvice` (`sno`, `about`) VALUES
(1, 'Welcome to my blog! Here, I aim to provide valuable advice and tips related to cars, specifically maintenance, and overall longevity. Owning a car can be a significant investment, and it\'s important to take good care of it to ensure that it lasts as long as possible. Whether you\'re a first-time car owner or a seasoned driver, my goal is to provide practical advice that can help you keep your car in top shape, save money on repairs and maintenance, and ultimately prolong its lifespan. From routine maintenance to troubleshooting common problems, I hope to provide you with the knowledge and tools you need to be a responsible and informed car owner.');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `sno` int(11) NOT NULL,
  `slug` varchar(25) NOT NULL,
  `sender_uname` varchar(30) NOT NULL,
  `comment` text NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `time` time NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`sno`, `slug`, `sender_uname`, `comment`, `date`, `time`) VALUES
(1, 'first-post', 'sufiyan_99', '👌', '2023-06-02', '00:00:00'),
(2, 'first-post', 'uvesh_9824', 'I agree 👍', '2023-06-02', '00:00:00'),
(3, 'first-post', 'sufiyan_99', '😊', '2023-06-02', '00:00:00'),
(4, 'second-post', 'mujammil_01', 'Awesome Blog 🙌', '2023-06-03', '00:00:00'),
(5, 'my-third-post', 'sufiyan_99', 'Nice Blog 😍', '2023-06-03', '15:56:40'),
(6, 'second-post', 'sufiyan_99', 'Awesome', '2023-06-03', '16:07:37'),
(7, 'first-post', 'sufiyan_99', 'Nice', '2023-06-03', '16:08:24'),
(8, 'first-post', 'mujammil_01', 'Wow', '2023-06-06', '13:11:07'),
(9, 'maruti-engage', 'mujammil_01', '👍', '2023-06-06', '13:28:27');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `reply` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `delete_status` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `username`, `email`, `phone_num`, `msg`, `reply`, `status`, `delete_status`, `date`) VALUES
(1, 'Sufiyan', 'sufiyan_99', 'sufiyanansari2222@gmail.com', '7573086544', 'Hello, This message is for testing purpose.', 'Ok i understand.', 'Readed', 'No', '2023-05-07 12:22:20'),
(2, 'Uvesh', 'uvesh_9824', 'uveshrajput9824@gmail.com', '9824509777', 'I need more information regarding car service & maintenance.', 'Sure, I will try to put some more information.\n\nThanks for your response.', 'Readed', 'No', '2023-05-07 12:28:34'),
(49, 'Sufiyan Ansari', 'sufiyan_99', 'sufiyanansari2222@gmail.com', '7573086544', 'I Like the EV Facts', NULL, 'Unreaded', 'Yes', '2023-06-05 14:47:27'),
(50, 'Uvesh Rajput', 'uvesh_9824', 'uveshrajput9824@gmail.com', '9824509777', 'I would love to know about the working of EV', 'Yeah Sure 👍', 'Readed', 'No', '2023-06-05 21:26:41'),
(52, 'Sufiyan Ansari', 'sufiyan_99', 'sufiyanansari2222@gmail.com', '7573086544', 'love your Content Man!!', 'Thanks Man!! 👍', 'Readed', 'No', '2023-06-06 21:04:05');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `sender_uname` varchar(30) DEFAULT NULL,
  `sender_name` text DEFAULT NULL,
  `title` text NOT NULL,
  `subtitle` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(25) NOT NULL,
  `date` date DEFAULT current_timestamp(),
  `time` time DEFAULT current_timestamp(),
  `visible` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `sender_uname`, `sender_name`, `title`, `subtitle`, `slug`, `content`, `img_file`, `date`, `time`, `visible`) VALUES
(1, 'sufiyan_99', 'Sufiyan Ansari', 'What makes a Good car and the Most Reliable Cars', 'Key Factors to Consider When Choosing a Dependable Vehicle for a Smooth Ride', 'first-post', 'The perfect, reliable car doesn\'t cost much to upkeep and gets really good miles per gallon, so they don\'t have to stop for fuel a lot.There are several factors that make a good car, and reliability is one of the most important. A good car should be safe, comfortable, efficient, and have good performance and handling. It should also be affordable to maintain, have good resale value, and provide a good driving experience overall.\r\n\r\nWhen it comes to reliability, the most reliable cars are those that have a proven track record of dependability and longevity. Some of the most reliable cars are those that are well-built, use high-quality materials, and have been tested extensively in a variety of driving conditions.\r\n\r\nAccording to various studies and surveys, some of the most reliable car brands include Toyota, Lexus, Mazda, Honda, and Subaru. These brands consistently rank highly in reliability surveys and have a reputation for building cars that are dependable and long-lasting.\r\n\r\nIn addition to brand reputation, factors such as regular maintenance and care, driving habits, and environmental conditions can also affect a car\'s reliability. It\'s important to take good care of your car by following the manufacturer\'s recommended maintenance schedule, driving carefully, and storing your car properly to ensure it stays reliable for years to come.', 'img1.jpeg', '2023-05-16', '21:30:58', 'Yes'),
(2, 'uvesh_9824', 'Uvesh Rajput', 'The Importance of Regular Car Maintenance: Keeping Your Vehicle in Top Shape.', 'Tips for Maintaining Your Car\'s Performance, Safety, and Longevity.', 'second-post', 'Maintaining your car is critical to ensuring its performance, safety, and longevity. Regular maintenance not only saves you money in the long run, but it also helps prevent breakdowns and accidents on the road. Here are some essential tips to keep your car in top shape:\r\n\r\nFollow the manufacturer\'s maintenance schedule: Your car\'s owner manual provides guidelines for regular maintenance, including oil changes, tire rotations, and other important tasks. Following this schedule can help you catch problems early on and prevent costly repairs down the line.\r\n\r\nCheck your tires regularly: Proper tire pressure and tread depth are essential for safe driving. Check your tire pressure at least once a month, and replace worn or damaged tires promptly.\r\n\r\nKeep your car clean: Regular washing and waxing can help protect your car\'s paint from damage caused by dirt, debris, and environmental factors like sunlight and rain.\r\n\r\nAddress any issues promptly: If you notice strange noises, warning lights, or other issues with your car, don\'t ignore them. Addressing problems early on can prevent more significant and expensive issues down the line.\r\n\r\nInvest in professional maintenance: While you can do many routine maintenance tasks yourself, it\'s essential to take your car to a qualified mechanic for more complex repairs and services. A professional mechanic can identify issues you may not have noticed and help keep your car running smoothly.\r\n\r\nBy following these tips, you can help ensure that your car stays in top shape for years to come. Regular maintenance can save you money, prevent accidents, and give you peace of mind on the road.', 'img2.jpeg', '2023-05-10', '16:58:29', 'Yes'),
(3, 'sufiyan_99', 'Sufiyan Ansari', 'The Importance of Regularly Checking and Changing the Car\'s Oil.', 'Preventing Engine Damage and Extending the Life of Your Vehicle.', 'my-third-post', 'Your car\'s oil is essential for keeping the engine running smoothly. Over time, the oil can become dirty and lose its effectiveness, which can cause serious damage to your engine. To avoid this, it\'s important to regularly check your car\'s oil level and change it as recommended by the manufacturer.\r\n\r\nChecking your car\'s oil level is a simple process that can be done in a matter of minutes. Begin by making sure your car is on level ground and turned off. Locate the dipstick, which is usually labeled and has a yellow or orange handle, and pull it out. Wipe it clean with a rag or paper towel and reinsert it into the tube. Remove it again and look at the level on the dipstick. If the oil level is below the recommended level, add more oil.\r\n\r\nIt\'s also important to change your car\'s oil regularly. The frequency of oil changes depends on your car\'s make and model, as well as your driving habits. Most manufacturers recommend an oil change every 5,000 to 7,500 miles, or every six months to a year. Regular oil changes can help prevent engine damage, improve fuel efficiency, and extend the life of your vehicle.\r\n\r\nDuring an oil change, the old oil is drained from the engine and replaced with fresh oil. The oil filter is also replaced to ensure that any contaminants in the oil are removed. Some car owners prefer to change their own oil, while others take their car to a mechanic or oil change service.\r\n\r\nIn addition to checking and changing your car\'s oil, it\'s important to use the right type of oil for your car. The recommended oil type can usually be found in the owner\'s manual or on the oil cap under the hood. Using the wrong type of oil can cause engine damage and void your warranty.\r\n\r\nIn conclusion, regularly checking and changing your car\'s oil is crucial for preventing engine damage and extending the life of your vehicle. It\'s a simple maintenance task that can save you money and prevent costly repairs down the road.', 'Cemagraphics.png', '2023-05-13', '21:30:03', 'Yes'),
(4, 'uvesh_9824', 'Uvesh Rajput', 'Paying Attention to Unusual Car Noises, Smells, and Vibrations.', 'Identifying Potential Problems and Preventing Costly Repairs.', 'fourth-post', 'Unusual noises, smells, and vibrations coming from your car can be signs of serious problems that should not be ignored. While some issues may be minor, others can lead to costly repairs or even a breakdown on the side of the road. It\'s important to pay attention to these warning signs and address them promptly.\r\n\r\nUnusual noises are one of the most common signs of a potential problem. Squeaking, grinding, or rattling noises can indicate issues with the brakes, suspension, or engine. Hissing or whistling noises may be a sign of a vacuum leak or a problem with the exhaust system. Screeching noises may indicate a loose or worn belt. If you hear any unusual noises coming from your car, it\'s important to have it checked by a mechanic.\r\n\r\nUnusual smells can also be a sign of a problem with your car. A burning smell may indicate an issue with the brakes or clutch. A sweet smell may indicate a coolant leak. A musty smell can be a sign of mold or mildew in the air conditioning system. If you notice any unusual smells coming from your car, it\'s important to have it checked by a mechanic.\r\n\r\nVibrations can be another sign of a problem with your car. If you feel a vibration in the steering wheel, it may be a sign of a problem with the tires or wheels. If you feel a vibration in the brake pedal, it may indicate an issue with the brakes. If you feel a vibration in the seat or floorboard, it may be a sign of a problem with the suspension or engine. If you feel any unusual vibrations coming from your car, it\'s important to have it checked by a mechanic.\r\n\r\nIgnoring these warning signs can lead to costly repairs and potentially dangerous situations. It\'s important to address any issues promptly to prevent further damage and ensure your safety on the road. Regular maintenance and inspections can also help identify potential problems before they become major issues.\r\n\r\nIn conclusion, paying attention to unusual noises, smells, and vibrations coming from your car is crucial for identifying potential problems and preventing costly repairs. If you notice any unusual warning signs, it\'s important to have your car checked by a mechanic. Regular maintenance and inspections can also help keep your car running smoothly and safely.', 'img4.jpg', '2023-05-08', '11:41:34', 'Yes'),
(5, 'mujammil_01', 'Mujammil Shaikh', 'Updated list of top 10 most reliable car in the World.', 'Top 10 car', 'fifth-post', '1. BMW. The 2022 BMW iX xDrive50. Tim Levin/Insider. ...\r\n2. GMC. GMC. ...\r\n3. Mazda. Mazda 6. ...\r\n4. Cadillac. The 2022 Cadillac Escalade Sport. ...\r\n5. Dodge. The Dodge Charger. ...\r\n6. Nissan (Tie) The 2023 Nissan Z. ...\r\n7. Mini (Tie) The 2022 Mini Hardtop. ...\r\n8. Hyundai (Tie) The Hyundai Tucson Hybrid.', 'img5.jpeg', '2023-06-06', '13:16:24', NULL),
(6, 'uvesh_9824', 'Uvesh Rajput', 'The Future of Transportation: How 2 Billion Vehicles Will Impact Our World.', 'Exploring the Opportunities and Challenges of a Rapidly Growing Vehicle Population.', 'sixth-post', 'The world is witnessing a rapid increase in the number of vehicles on the road, with experts predicting that the number of vehicles in use worldwide will reach 2 billion by 2040. This growth is driven by a combination of factors, including population growth, urbanization, and rising incomes in developing countries. While this growth presents significant opportunities for economic development and improved mobility, it also poses a range of challenges, from environmental concerns to congestion and safety issues.\r\n\r\nOne of the biggest challenges of this growth is its impact on the environment. The transportation sector is a major contributor to greenhouse gas emissions, which are a leading cause of climate change. As the number of vehicles on the road continues to grow, so does the need for clean and sustainable transportation solutions. Governments, businesses, and individuals are all looking for ways to reduce emissions and shift towards more sustainable modes of transportation, such as electric vehicles, public transit, and cycling.\r\n\r\nAnother challenge of a rapidly growing vehicle population is congestion. Traffic jams can cause significant economic costs, from lost productivity to increased fuel consumption and emissions. To address this challenge, cities are exploring a range of solutions, from congestion pricing to the development of new transportation modes such as autonomous vehicles and high-speed rail.\r\n\r\nSafety is also a major concern with a growing number of vehicles on the road. Accidents can cause significant human and economic costs, and governments are taking steps to improve road safety through improved infrastructure, regulation, and education.\r\n\r\nDespite these challenges, the growth of the vehicle population also presents significant opportunities for economic development and improved mobility. The automotive industry is a major contributor to global GDP, and the growth of electric vehicles and other new technologies is driving innovation and creating new business opportunities. In addition, improved mobility can have significant social and economic benefits, from increased access to healthcare and education to reduced inequality.\r\n\r\nIn conclusion, the growth of the vehicle population presents a complex set of challenges and opportunities. Governments, businesses, and individuals must work together to develop and implement sustainable transportation solutions that address these challenges while promoting economic development and improving mobility for all.', 'img6.jpg', '2023-05-10', '01:00:00', NULL),
(7, 'mujammil_01', 'Mujammil Shaikh', 'The Environmental Impact of Manufacturing 70 Million Cars Every Year', 'Examining the Carbon Footprint and Sustainability of the Automotive Industry.', 'seventh-post', 'The global automotive industry produces a staggering 70 million cars every year. This level of production is driven by high consumer demand for cars, and the industry\'s ability to produce them at scale. However, the manufacturing of 70 million cars every year has significant environmental impacts, particularly in terms of carbon emissions and sustainability.\r\n\r\nThe production of cars requires large amounts of energy, from the extraction of raw materials to the assembly of parts into a finished vehicle. This energy consumption contributes to carbon emissions and the exacerbation of climate change. In addition, the manufacturing process generates waste, including hazardous chemicals and non-recyclable materials, which can pollute the environment and harm wildlife.\r\n\r\nTo address these environmental concerns, the automotive industry is exploring ways to reduce its carbon footprint and increase sustainability. This includes investing in cleaner energy sources, such as renewable energy, and using more environmentally friendly materials in the production process. Some car manufacturers are also exploring alternative manufacturing methods, such as 3D printing, that could potentially reduce waste and improve efficiency.\r\n\r\nAs consumers, we can also play a role in reducing the environmental impact of the automotive industry. Choosing fuel-efficient cars, using public transportation, carpooling, and investing in electric or hybrid vehicles are just some of the ways we can reduce our carbon footprint and contribute to a more sustainable future.\r\n\r\nWhile the automotive industry has made progress in addressing its environmental impact, much more needs to be done. As the demand for cars continues to grow, it is essential that the industry continues to innovate and adopt sustainable practices to minimize its environmental footprint.', 'img7.png', '2023-05-10', '16:02:08', NULL),
(8, 'sufiyan_99', 'Sufiyan Ansari', 'Maruti Suzuki Grand Vitara', 'The Maruti Suzuki Grand Vitara has been crowned the Car of the Year at the Autocar Awards 2023', 'ninth-post-new', 'The Maruti Suzuki Grand Vitara has been crowned the Car of the Year at the Autocar Awards 2023, while the Bajaj Pulsar N160 is the Bike of the Year. The Grand Vitara had to contest closely with the likes of the Mahindra Scorpio N, Toyota Innova Hycross, Hyundai Tucson and several others to bag the top honour. Maruti’s first midsize SUV impressed the jury with its fuel-efficient hybrid system, clever packaging and quality that Maruti\'s flagship has brought to the table.\r\n\r\nThe Maruti Grand Vitara not only won the top honour overall, but it also topped its own segment with the Midsize SUV of the Year title. Meanwhile, the Mahindra Scorpio N took home the Off-roader of the year award – it impressed with its fabulous engines, robust build and hardcore off-roading ability.\r\n\r\nMoving up the price ladder, the Hyundai Tucson was declared as the Executive SUV of the year, topping others like the Jeep Meridian and BYD Atto 3. The Tucson impressed the jury for its radical looks and all the technology it has brought into the segment. The Audi Q3 was announced as the luxury SUV of the year, over contenders like the Volvo XC40 Recharge and Jeep Grand Cherokee. In the MPV category, the new Toyota Innova Hycross moved the goalposts further in its segment, and likewise, was crowned as the MPV of the Year.\r\n\r\nWhile SUVs continue to be the majority, last year saw quite a few competent hatchbacks and sedans being launched in the market. The Maruti Suzuki Baleno bagged the Hatchback of the Year title, while the Volkswagen Virtus took away the award for Midsize Sedan of the Year. Meanwhile, the Mercedes-Maybach S-Class was adjudged as the Luxury sedan of the year, over its stablemates the new C-Class and all-electric EQS.\r\n\r\nEven though styling is a subjective matter, our jury agreed that the radical looking Kia EV6 was a deserving winner of the Best Design and Styling Award. The Performance Car of the Year award went to the phenomenal driver’s delight that is the Porsche 911 GT3 RS, while the Green Car of the Year award was given to the humble and practical Tata Tiago EV.', 'Grand_Vitara.jpg', '2023-05-16', '19:17:06', 'Yes'),
(9, 'sufiyan_99', 'Sufiyan Ansari', '5 Reasons to Wait for Maruti Engage Over Toyota Innova Hycross', 'Maruti Suzuki is about to launch its 7-seater Engage MPV/SUV in our market and we list out why it might be a good alternative to the Toyota Innova Hycross on which it will be based.', 'maruti-engage', 'The country’s largest carmaker, Maruti Suzuki India Limited, is getting ready to launch its most expensive model to date in the coming months. We’re talking about the Maruti Suzuki Engage premium MPV. This forthcoming MPV will be another badge-engineered model created in collaboration with the other Japanese automotive giant, Toyota Kirloskar Motor. The Engage MPV will be based on the Toyota Innova Hycross and will be slightly tweaked on the outside to differentiate it from the Innova Hycross. Recently, a video render of what this newest MPV from Maruti Suzuki could look like has surfaced online.\r\n\r\nThe video rendering of this forthcoming MPV has been shared on YouTube by Bagrawala Designs on their channel. The video starts with the front of the Engage MPV. It can be noted that in the video, the front grille of the Toyota Innova Hycross has been changed to the grille of Maruti Suzuki’s current flagship, the Grand Vitara. Additionally, the Toyota badge has been replaced by the Suzuki insignia, and the new signature Maruti Suzuki chrome strip on the grille has also been added. Apart from this, most of the front is exactly the same as the outgoing Toyota Innova Hycross.', 'maruti_engage.jpg', '2023-05-16', '20:19:07', 'Yes'),
(33, 'sufiyan_99', 'Sufiyan Ansari', 'The Rise of Electric Vehicles (EVs)', 'Exploring the Benefits, Challenges, and Growing Adoption of Electric Cars', 'EV-Car', 'Electric vehicles (EVs) have emerged as a promising solution to the environmental and sustainability challenges posed by traditional gasoline-powered cars. With advancements in technology and growing environmental awareness, EVs are rapidly gaining popularity and reshaping the future of transportation.\r\n\r\nBenefits of Electric Vehicles:\r\n\r\nEnvironmental Impact: EVs produce zero tailpipe emissions, reducing air pollution and greenhouse gas emissions. They play a crucial role in combating climate change and improving air quality in urban areas.\r\n\r\nEnergy Efficiency: EVs are more energy-efficient than internal combustion engine vehicles. They convert a higher percentage of stored energy into forward motion, resulting in greater energy savings and reduced dependence on fossil fuels.\r\n\r\nCost Savings: Over the long term, EVs offer potential cost savings in terms of fuel and maintenance. Electricity is generally cheaper than gasoline, and EVs have fewer moving parts, requiring less frequent maintenance and lower repair costs.\r\n\r\nRenewable Energy Integration: EVs can be charged using electricity from renewable energy sources, such as solar or wind power. This integration promotes a cleaner and more sustainable energy ecosystem.\r\n\r\nChallenges and Considerations:\r\n\r\nLimited Range and Charging Infrastructure: EVs currently face limitations regarding driving range and the availability of charging infrastructure. However, advancements in battery technology and the expansion of charging networks are addressing these concerns.\r\n\r\nUpfront Cost: The initial purchase price of EVs can be higher compared to conventional cars due to the cost of batteries and advanced technologies. However, as technology advances and economies of scale improve, prices are expected to become more competitive.\r\n\r\nBattery Life and Recycling: The lifespan of EV batteries and their recycling and disposal present ongoing challenges. Research and development efforts are focused on improving battery durability, recycling methods, and sustainable battery materials.\r\n\r\nGrowing Adoption and Future Outlook:\r\n\r\nThe adoption of EVs is on the rise globally. Governments, businesses, and consumers are increasingly recognizing the benefits and potential of electric vehicles. Incentives, subsidies, and regulations promoting EV adoption, along with the introduction of more affordable models, are driving market growth.\r\n\r\nAutomakers are investing heavily in EV research and development, with many pledging to transition to electric vehicle production entirely in the coming years. Technological advancements, such as faster-charging capabilities and increased driving range, continue to enhance the appeal and viability of electric cars.\r\n\r\nIn conclusion, electric vehicles are revolutionizing the automotive industry and offering a sustainable and environmentally friendly alternative to conventional cars. While challenges remain, the growing adoption of EVs, along with supportive policies and advancing technologies, indicate a promising future for electric transportation.', 'EV-Car.jpg', '2023-06-06', '14:12:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `sno` int(11) NOT NULL,
  `sender_name` text NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(150) NOT NULL,
  `about` text DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`sno`, `sender_name`, `username`, `email`, `password`, `about`, `date`, `time`) VALUES
(1, 'Sufiyan Ansari', 'sufiyan_99', 'sufiyanansari2222@gmail.com', 'eadcf3db7ab8b490d07c0bc93d858800', 'Sufiyan, the person behind the car-related facts and news posts, is an ardent automotive enthusiast and a true authority in the field. With an extensive knowledge base and a genuine passion for cars, Sufiyan brings a unique perspective to the world of automotive journalism.\r\n\r\nSufiyan\'s posts are a testament to his unwavering dedication to providing accurate, well-researched, and up-to-date information. Whether it\'s reviewing the latest car models, discussing advancements in automotive technology, or sharing insights into industry trends, Sufiyan\'s writing is both informative and engaging.\r\n\r\nWhat sets Sufiyan apart is his ability to present complex information in a way that is accessible to readers of all backgrounds. His attention to detail and ability to explain technical concepts in a clear and concise manner make his posts a valuable resource for both casual car enthusiasts and seasoned automotive professionals.\r\n\r\nSufiyan\'s love for cars goes beyond just the mechanical aspects. He appreciates the artistry of automotive design and recognizes the impact of cars on our culture and society. From classic models to cutting-edge electric vehicles, Sufiyan covers a wide range of topics, ensuring that his readers are well-informed and inspired.\r\n\r\nWhether you\'re seeking the latest car news, detailed car reviews, or simply a deeper understanding of the automotive world, Sufiyan\'s posts provide a wealth of knowledge and an enjoyable reading experience for anyone with a passion for cars.', '2023-05-13', '15:43:08'),
(2, 'Uvesh Rajput', 'uvesh_9824', 'uveshrajput9824@gmail.com', '8cb573f4d3c8102baaf08202bbe2785f', 'My name is Uvesh Rajput, I post facts about the car and bike.', '2023-05-13', '15:45:40'),
(13, 'Mujammil Shaikh', 'mujammil_01', 'mujammilshaikh01@gmail.com', 'ae9337c8e44cf2babb9cd6688329733f', 'Hi Guys My self Mujammil Shiakh', '2023-06-02', '20:40:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_autoadvice`
--
ALTER TABLE `about_autoadvice`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about_autoadvice`
--
ALTER TABLE `about_autoadvice`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
