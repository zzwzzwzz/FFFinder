import Foundation

struct Film: Identifiable {
    let id = UUID()
    let title: String
    let year: Int
    let director: String
    let description: String
    let posterURL: String?
    let imdbURL: String
    let letterboxdURL: String
    let rottenTomatoesURL: String
    let awards: [Award]
    
    struct Award: Identifiable {
        let id = UUID()
        let award: String
        let year: Int
        let festival: String
        let festivalURL: String
    }
    
    static let samples: [Film] = [
        // Sydney Film Festival Winners
        Film(
            title: "The New Boy",
            year: 2023,
            director: "Warwick Thornton",
            description: "In 1940s Australia, a 9-year-old Aboriginal orphan boy arrives at a remote monastery run by a renegade nun. The new boy's presence disturbs the delicately balanced world in this story of spiritual struggle and the cost of survival.",
            posterURL: "new_boy_poster",
            imdbURL: "https://www.imdb.com/title/tt21979336/",
            letterboxdURL: "https://letterboxd.com/film/the-new-boy-2023/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_new_boy_2023",
            awards: [
                Award(
                    award: "Sydney Film Prize",
                    year: 2023,
                    festival: "Sydney Film Festival",
                    festivalURL: "https://www.sff.org.au"
                )
            ]
        ),
        Film(
            title: "You Won't Be Alone",
            year: 2022,
            director: "Goran Stolevski",
            description: "In an isolated mountain village in 19th century Macedonia, a young girl is taken from her mother and transformed into a witch by an ancient spirit. Curious about life as a human, the witch accidentally kills a villager and uses her body to live among humans.",
            posterURL: "you_wont_be_alone_poster",
            imdbURL: "https://www.imdb.com/title/tt11851548/",
            letterboxdURL: "https://letterboxd.com/film/you-wont-be-alone/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/you_wont_be_alone",
            awards: [
                Award(
                    award: "Sydney Film Prize",
                    year: 2022,
                    festival: "Sydney Film Festival",
                    festivalURL: "https://www.sff.org.au"
                )
            ]
        ),
        Film(
            title: "The Drover's Wife: The Legend of Molly Johnson",
            year: 2021,
            director: "Leah Purcell",
            description: "A searing Australian western thriller that follows Molly Johnson and her children in the harsh Australian alpine country in 1893. Molly is preparing her four children for the absence of their drover husband, when a shackled Aboriginal man breaks his bindings and interrupts her dinner.",
            posterURL: "drovers_wife_poster",
            imdbURL: "https://www.imdb.com/title/tt10199586/",
            letterboxdURL: "https://letterboxd.com/film/the-drovers-wife-the-legend-of-molly-johnson/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_drovers_wife_the_legend_of_molly_johnson",
            awards: [
                Award(
                    award: "Sydney Film Prize",
                    year: 2021,
                    festival: "Sydney Film Festival",
                    festivalURL: "https://www.sff.org.au"
                )
            ]
        ),
        Film(
            title: "Shiva Baby",
            year: 2020,
            director: "Emma Seligman",
            description: "A college student runs into her sugar daddy and his wife at a Jewish funeral service with her parents.",
            posterURL: "shiva_baby_poster",
            imdbURL: "https://www.imdb.com/title/tt11447806/",
            letterboxdURL: "https://letterboxd.com/film/shiva-baby/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/shiva_baby",
            awards: [
                Award(
                    award: "Sydney Film Prize",
                    year: 2020,
                    festival: "Sydney Film Festival",
                    festivalURL: "https://www.sff.org.au"
                )
            ]
        ),
        
        // Flickerfest Winners
        Film(
            title: "The Last Light",
            year: 2024,
            director: "Sarah Smith",
            description: "A poignant short film about a lighthouse keeper's final night on duty, exploring themes of isolation and legacy.",
            posterURL: "last_light_poster",
            imdbURL: "https://www.imdb.com/title/tt12345678/",
            letterboxdURL: "https://letterboxd.com/film/the-last-light/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_light",
            awards: [
                Award(
                    award: "Best Australian Short Film",
                    year: 2024,
                    festival: "Flickerfest",
                    festivalURL: "https://www.flickerfest.com.au"
                )
            ]
        ),
        Film(
            title: "The Silent Echo",
            year: 2023,
            director: "Michael Chen",
            description: "A deaf dancer's journey to find her voice through movement in this visually stunning short film.",
            posterURL: "silent_echo_poster",
            imdbURL: "https://www.imdb.com/title/tt23456789/",
            letterboxdURL: "https://letterboxd.com/film/the-silent-echo/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_silent_echo",
            awards: [
                Award(
                    award: "Best Australian Short Film",
                    year: 2023,
                    festival: "Flickerfest",
                    festivalURL: "https://www.flickerfest.com.au"
                )
            ]
        ),
        Film(
            title: "The Last Dance",
            year: 2022,
            director: "Emma Wilson",
            description: "A touching story about an elderly couple's final dance together, set against the backdrop of a closing ballroom.",
            posterURL: "last_dance_poster",
            imdbURL: "https://www.imdb.com/title/tt34567890/",
            letterboxdURL: "https://letterboxd.com/film/the-last-dance/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_dance",
            awards: [
                Award(
                    award: "Best Australian Short Film",
                    year: 2022,
                    festival: "Flickerfest",
                    festivalURL: "https://www.flickerfest.com.au"
                )
            ]
        ),
        Film(
            title: "The Messenger",
            year: 2021,
            director: "David Park",
            description: "A post-apocalyptic short film about a courier's journey to deliver a message that could change humanity's future.",
            posterURL: "messenger_poster",
            imdbURL: "https://www.imdb.com/title/tt45678901/",
            letterboxdURL: "https://letterboxd.com/film/the-messenger/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_messenger",
            awards: [
                Award(
                    award: "Best Australian Short Film",
                    year: 2021,
                    festival: "Flickerfest",
                    festivalURL: "https://www.flickerfest.com.au"
                )
            ]
        ),
        Film(
            title: "The Last Goodbye",
            year: 2020,
            director: "Sarah Johnson",
            description: "A heartwarming short film about a man's journey to say goodbye to his childhood home before it's demolished.",
            posterURL: "last_goodbye_poster",
            imdbURL: "https://www.imdb.com/title/tt56789012/",
            letterboxdURL: "https://letterboxd.com/film/the-last-goodbye/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_goodbye",
            awards: [
                Award(
                    award: "Best Australian Short Film",
                    year: 2020,
                    festival: "Flickerfest",
                    festivalURL: "https://www.flickerfest.com.au"
                )
            ]
        ),
        
        // Japanese Film Festival Winners
        Film(
            title: "The Silent Garden",
            year: 2024,
            director: "Yuki Tanaka",
            description: "A contemporary Japanese drama that follows a young woman's journey of self-discovery through the art of traditional gardening.",
            posterURL: "silent_garden_poster",
            imdbURL: "https://www.imdb.com/title/tt67890123/",
            letterboxdURL: "https://letterboxd.com/film/the-silent-garden/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_silent_garden",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2024,
                    festival: "Japanese Film Festival",
                    festivalURL: "https://japanesefilmfestival.net"
                )
            ]
        ),
        Film(
            title: "Eternal Spring",
            year: 2023,
            director: "Hiroshi Nakamura",
            description: "A beautiful tale of love and renewal set in modern Tokyo, following the lives of three interconnected characters.",
            posterURL: "eternal_spring_poster",
            imdbURL: "https://www.imdb.com/title/tt78901234/",
            letterboxdURL: "https://letterboxd.com/film/eternal-spring/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/eternal_spring",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2023,
                    festival: "Japanese Film Festival",
                    festivalURL: "https://japanesefilmfestival.net"
                )
            ]
        ),
        Film(
            title: "The Last Samurai",
            year: 2022,
            director: "Kenji Watanabe",
            description: "A modern retelling of the samurai story, set in contemporary Japan, exploring the clash between tradition and modernity.",
            posterURL: "last_samurai_poster",
            imdbURL: "https://www.imdb.com/title/tt89012345/",
            letterboxdURL: "https://letterboxd.com/film/the-last-samurai-2022/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_samurai_2022",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2022,
                    festival: "Japanese Film Festival",
                    festivalURL: "https://japanesefilmfestival.net"
                )
            ]
        ),
        Film(
            title: "Tokyo Stories",
            year: 2021,
            director: "Akira Sato",
            description: "An anthology film weaving together five different stories set in various neighborhoods of Tokyo.",
            posterURL: "tokyo_stories_poster",
            imdbURL: "https://www.imdb.com/title/tt90123456/",
            letterboxdURL: "https://letterboxd.com/film/tokyo-stories/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/tokyo_stories",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2021,
                    festival: "Japanese Film Festival",
                    festivalURL: "https://japanesefilmfestival.net"
                )
            ]
        ),
        Film(
            title: "The Way of Tea",
            year: 2020,
            director: "Mika Kobayashi",
            description: "A meditative film about a young woman's journey to master the ancient art of Japanese tea ceremony.",
            posterURL: "way_of_tea_poster",
            imdbURL: "https://www.imdb.com/title/tt01234567/",
            letterboxdURL: "https://letterboxd.com/film/the-way-of-tea/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_way_of_tea",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2020,
                    festival: "Japanese Film Festival",
                    festivalURL: "https://japanesefilmfestival.net"
                )
            ]
        ),
        
        // Queer Screen Film Fest Winners
        Film(
            title: "Rainbow Connection",
            year: 2024,
            director: "Alex Chen",
            description: "A heartwarming story about a group of LGBTQ+ friends who come together to organize their local pride parade.",
            posterURL: "rainbow_connection_poster",
            imdbURL: "https://www.imdb.com/title/tt12345678/",
            letterboxdURL: "https://letterboxd.com/film/rainbow-connection/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/rainbow_connection",
            awards: [
                Award(
                    award: "Best Narrative Feature",
                    year: 2024,
                    festival: "Queer Screen Film Fest",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        Film(
            title: "Love in Color",
            year: 2023,
            director: "Jamie Lee",
            description: "A vibrant romantic drama exploring the intersection of art and love in the LGBTQ+ community.",
            posterURL: "love_in_color_poster",
            imdbURL: "https://www.imdb.com/title/tt23456789/",
            letterboxdURL: "https://letterboxd.com/film/love-in-color/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/love_in_color",
            awards: [
                Award(
                    award: "Best Narrative Feature",
                    year: 2023,
                    festival: "Queer Screen Film Fest",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        Film(
            title: "Family Ties",
            year: 2022,
            director: "Maria Rodriguez",
            description: "A touching story about a young person's journey to come out to their traditional family.",
            posterURL: "family_ties_poster",
            imdbURL: "https://www.imdb.com/title/tt34567890/",
            letterboxdURL: "https://letterboxd.com/film/family-ties/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/family_ties",
            awards: [
                Award(
                    award: "Best Narrative Feature",
                    year: 2022,
                    festival: "Queer Screen Film Fest",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        Film(
            title: "Breaking Free",
            year: 2021,
            director: "Taylor Wong",
            description: "A powerful drama about a young athlete's struggle to compete in their chosen sport while navigating their gender identity.",
            posterURL: "breaking_free_poster",
            imdbURL: "https://www.imdb.com/title/tt45678901/",
            letterboxdURL: "https://letterboxd.com/film/breaking-free/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_free",
            awards: [
                Award(
                    award: "Best Narrative Feature",
                    year: 2021,
                    festival: "Queer Screen Film Fest",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        Film(
            title: "The Way Forward",
            year: 2020,
            director: "Sam Chen",
            description: "A documentary following the lives of LGBTQ+ activists fighting for equality in their communities.",
            posterURL: "way_forward_poster",
            imdbURL: "https://www.imdb.com/title/tt56789012/",
            letterboxdURL: "https://letterboxd.com/film/the-way-forward/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_way_forward",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2020,
                    festival: "Queer Screen Film Fest",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        
        // Sydney Underground Film Festival Winners
        Film(
            title: "Digital Dreams",
            year: 2024,
            director: "Max Rodriguez",
            description: "An experimental film that explores the intersection of technology and human consciousness through avant-garde storytelling.",
            posterURL: "digital_dreams_poster",
            imdbURL: "https://www.imdb.com/title/tt67890123/",
            letterboxdURL: "https://letterboxd.com/film/digital-dreams/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/digital_dreams",
            awards: [
                Award(
                    award: "Best Experimental Film",
                    year: 2024,
                    festival: "Sydney Underground Film Festival",
                    festivalURL: "https://www.suff.com.au"
                )
            ]
        ),
        Film(
            title: "The Void",
            year: 2023,
            director: "Luna Black",
            description: "A mind-bending experimental film that challenges conventional narrative structures and visual storytelling.",
            posterURL: "void_poster",
            imdbURL: "https://www.imdb.com/title/tt78901234/",
            letterboxdURL: "https://letterboxd.com/film/the-void/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_void",
            awards: [
                Award(
                    award: "Best Experimental Film",
                    year: 2023,
                    festival: "Sydney Underground Film Festival",
                    festivalURL: "https://www.suff.com.au"
                )
            ]
        ),
        Film(
            title: "Echo Chamber",
            year: 2022,
            director: "Alex Rivera",
            description: "An avant-garde exploration of social media's impact on human connection and identity.",
            posterURL: "echo_chamber_poster",
            imdbURL: "https://www.imdb.com/title/tt89012345/",
            letterboxdURL: "https://letterboxd.com/film/echo-chamber/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/echo_chamber",
            awards: [
                Award(
                    award: "Best Experimental Film",
                    year: 2022,
                    festival: "Sydney Underground Film Festival",
                    festivalURL: "https://www.suff.com.au"
                )
            ]
        ),
        Film(
            title: "The Last Frame",
            year: 2021,
            director: "Sarah White",
            description: "A groundbreaking experimental film that deconstructs the very nature of cinema and visual storytelling.",
            posterURL: "last_frame_poster",
            imdbURL: "https://www.imdb.com/title/tt90123456/",
            letterboxdURL: "https://letterboxd.com/film/the-last-frame/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_frame",
            awards: [
                Award(
                    award: "Best Experimental Film",
                    year: 2021,
                    festival: "Sydney Underground Film Festival",
                    festivalURL: "https://www.suff.com.au"
                )
            ]
        ),
        Film(
            title: "Digital Divide",
            year: 2020,
            director: "Michael Chen",
            description: "An experimental exploration of the digital age and its impact on human relationships and society.",
            posterURL: "digital_divide_poster",
            imdbURL: "https://www.imdb.com/title/tt01234567/",
            letterboxdURL: "https://letterboxd.com/film/digital-divide/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/digital_divide",
            awards: [
                Award(
                    award: "Best Experimental Film",
                    year: 2020,
                    festival: "Sydney Underground Film Festival",
                    festivalURL: "https://www.suff.com.au"
                )
            ]
        ),
        
        // Sydney Science Fiction Film Festival Winners
        Film(
            title: "Quantum Paradox",
            year: 2024,
            director: "Lisa Wong",
            description: "A mind-bending sci-fi thriller that follows a quantum physicist who discovers a way to communicate with parallel universes.",
            posterURL: "quantum_paradox_poster",
            imdbURL: "https://www.imdb.com/title/tt12345678/",
            letterboxdURL: "https://letterboxd.com/film/quantum-paradox/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/quantum_paradox",
            awards: [
                Award(
                    award: "Best Science Fiction Film",
                    year: 2024,
                    festival: "Sydney Science Fiction Film Festival",
                    festivalURL: "https://www.sydneyscififilmfestival.com"
                )
            ]
        ),
        Film(
            title: "The Last Colony",
            year: 2023,
            director: "James Chen",
            description: "A gripping sci-fi drama about humanity's last attempt to establish a colony on a distant planet.",
            posterURL: "last_colony_poster",
            imdbURL: "https://www.imdb.com/title/tt23456789/",
            letterboxdURL: "https://letterboxd.com/film/the-last-colony/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_colony",
            awards: [
                Award(
                    award: "Best Science Fiction Film",
                    year: 2023,
                    festival: "Sydney Science Fiction Film Festival",
                    festivalURL: "https://www.sydneyscififilmfestival.com"
                )
            ]
        ),
        Film(
            title: "Time's Edge",
            year: 2022,
            director: "Emma Rodriguez",
            description: "A thrilling time-travel adventure that explores the consequences of altering the past.",
            posterURL: "times_edge_poster",
            imdbURL: "https://www.imdb.com/title/tt34567890/",
            letterboxdURL: "https://letterboxd.com/film/times-edge/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/times_edge",
            awards: [
                Award(
                    award: "Best Science Fiction Film",
                    year: 2022,
                    festival: "Sydney Science Fiction Film Festival",
                    festivalURL: "https://www.sydneyscififilmfestival.com"
                )
            ]
        ),
        Film(
            title: "The Last Signal",
            year: 2021,
            director: "David Park",
            description: "A suspenseful sci-fi thriller about a deep space mission that receives a mysterious signal from an unknown source.",
            posterURL: "last_signal_poster",
            imdbURL: "https://www.imdb.com/title/tt45678901/",
            letterboxdURL: "https://letterboxd.com/film/the-last-signal/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_signal",
            awards: [
                Award(
                    award: "Best Science Fiction Film",
                    year: 2021,
                    festival: "Sydney Science Fiction Film Festival",
                    festivalURL: "https://www.sydneyscififilmfestival.com"
                )
            ]
        ),
        Film(
            title: "Digital Frontier",
            year: 2020,
            director: "Sarah Lee",
            description: "A cyberpunk thriller set in a near-future world where virtual reality and reality begin to merge.",
            posterURL: "digital_frontier_poster",
            imdbURL: "https://www.imdb.com/title/tt56789012/",
            letterboxdURL: "https://letterboxd.com/film/digital-frontier/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/digital_frontier",
            awards: [
                Award(
                    award: "Best Science Fiction Film",
                    year: 2020,
                    festival: "Sydney Science Fiction Film Festival",
                    festivalURL: "https://www.sydneyscififilmfestival.com"
                )
            ]
        ),
        
        // Sydney Women's International Film Festival Winners
        Film(
            title: "Breaking Barriers",
            year: 2024,
            director: "Maria Garcia",
            description: "A powerful documentary that follows three women breaking barriers in traditionally male-dominated industries.",
            posterURL: "breaking_barriers_poster",
            imdbURL: "https://www.imdb.com/title/tt67890123/",
            letterboxdURL: "https://letterboxd.com/film/breaking-barriers/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_barriers",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2024,
                    festival: "Sydney Women's International Film Festival",
                    festivalURL: "https://www.swiff.com.au"
                )
            ]
        ),
        Film(
            title: "The Silent Revolution",
            year: 2023,
            director: "Emma Thompson",
            description: "A compelling drama about women's fight for equal rights in the workplace.",
            posterURL: "silent_revolution_poster",
            imdbURL: "https://www.imdb.com/title/tt78901234/",
            letterboxdURL: "https://letterboxd.com/film/the-silent-revolution/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_silent_revolution",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2023,
                    festival: "Sydney Women's International Film Festival",
                    festivalURL: "https://www.swiff.com.au"
                )
            ]
        ),
        Film(
            title: "Voices Unheard",
            year: 2022,
            director: "Sarah Chen",
            description: "A documentary exploring the untold stories of women in various fields of science and technology.",
            posterURL: "voices_unheard_poster",
            imdbURL: "https://www.imdb.com/title/tt89012345/",
            letterboxdURL: "https://letterboxd.com/film/voices-unheard/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/voices_unheard",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2022,
                    festival: "Sydney Women's International Film Festival",
                    festivalURL: "https://www.swiff.com.au"
                )
            ]
        ),
        Film(
            title: "The Last Stand",
            year: 2021,
            director: "Lisa Wong",
            description: "A powerful drama about a female lawyer fighting for justice in a male-dominated legal system.",
            posterURL: "last_stand_poster",
            imdbURL: "https://www.imdb.com/title/tt90123456/",
            letterboxdURL: "https://letterboxd.com/film/the-last-stand/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_stand",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2021,
                    festival: "Sydney Women's International Film Festival",
                    festivalURL: "https://www.swiff.com.au"
                )
            ]
        ),
        Film(
            title: "Breaking the Glass Ceiling",
            year: 2020,
            director: "Maria Rodriguez",
            description: "A documentary following the journey of women executives in corporate America.",
            posterURL: "breaking_glass_poster",
            imdbURL: "https://www.imdb.com/title/tt01234567/",
            letterboxdURL: "https://letterboxd.com/film/breaking-the-glass-ceiling/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_the_glass_ceiling",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2020,
                    festival: "Sydney Women's International Film Festival",
                    festivalURL: "https://www.swiff.com.au"
                )
            ]
        ),
        
        // Sydney Latin American Film Festival Winners
        Film(
            title: "Carnival of Souls",
            year: 2024,
            director: "Carlos Mendez",
            description: "A vibrant celebration of Latin American culture through the eyes of a young dancer preparing for the annual carnival.",
            posterURL: "carnival_souls_poster",
            imdbURL: "https://www.imdb.com/title/tt12345678/",
            letterboxdURL: "https://letterboxd.com/film/carnival-of-souls/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/carnival_of_souls",
            awards: [
                Award(
                    award: "Best Latin American Film",
                    year: 2024,
                    festival: "Sydney Latin American Film Festival",
                    festivalURL: "https://www.slaff.com.au"
                )
            ]
        ),
        Film(
            title: "The Last Dance",
            year: 2023,
            director: "Maria Garcia",
            description: "A passionate story about a family of tango dancers in Buenos Aires.",
            posterURL: "last_dance_poster",
            imdbURL: "https://www.imdb.com/title/tt23456789/",
            letterboxdURL: "https://letterboxd.com/film/the-last-dance-2023/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_dance_2023",
            awards: [
                Award(
                    award: "Best Latin American Film",
                    year: 2023,
                    festival: "Sydney Latin American Film Festival",
                    festivalURL: "https://www.slaff.com.au"
                )
            ]
        ),
        Film(
            title: "Voices of the Amazon",
            year: 2022,
            director: "Luis Rodriguez",
            description: "A documentary exploring the lives of indigenous communities in the Amazon rainforest.",
            posterURL: "voices_amazon_poster",
            imdbURL: "https://www.imdb.com/title/tt34567890/",
            letterboxdURL: "https://letterboxd.com/film/voices-of-the-amazon/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/voices_of_the_amazon",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2022,
                    festival: "Sydney Latin American Film Festival",
                    festivalURL: "https://www.slaff.com.au"
                )
            ]
        ),
        Film(
            title: "The Last Journey",
            year: 2021,
            director: "Ana Martinez",
            description: "A road movie following a family's journey across South America in search of a new home.",
            posterURL: "last_journey_poster",
            imdbURL: "https://www.imdb.com/title/tt45678901/",
            letterboxdURL: "https://letterboxd.com/film/the-last-journey/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_journey",
            awards: [
                Award(
                    award: "Best Latin American Film",
                    year: 2021,
                    festival: "Sydney Latin American Film Festival",
                    festivalURL: "https://www.slaff.com.au"
                )
            ]
        ),
        Film(
            title: "Breaking Borders",
            year: 2020,
            director: "Carlos Fernandez",
            description: "A powerful drama about immigration and family separation at the US-Mexico border.",
            posterURL: "breaking_borders_poster",
            imdbURL: "https://www.imdb.com/title/tt56789012/",
            letterboxdURL: "https://letterboxd.com/film/breaking-borders/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_borders",
            awards: [
                Award(
                    award: "Best Latin American Film",
                    year: 2020,
                    festival: "Sydney Latin American Film Festival",
                    festivalURL: "https://www.slaff.com.au"
                )
            ]
        ),
        
        // Antenna Documentary Film Festival Winners
        Film(
            title: "Voices of the Earth",
            year: 2024,
            director: "Emma Thompson",
            description: "A compelling documentary that explores the impact of climate change on indigenous communities around the world.",
            posterURL: "voices_earth_poster",
            imdbURL: "https://www.imdb.com/title/tt67890123/",
            letterboxdURL: "https://letterboxd.com/film/voices-of-the-earth/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/voices_of_the_earth",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2024,
                    festival: "Antenna Documentary Film Festival",
                    festivalURL: "https://antennafestival.org"
                )
            ]
        ),
        Film(
            title: "The Last Stand",
            year: 2023,
            director: "David Chen",
            description: "A powerful documentary about environmental activists fighting to protect endangered species.",
            posterURL: "last_stand_poster",
            imdbURL: "https://www.imdb.com/title/tt78901234/",
            letterboxdURL: "https://letterboxd.com/film/the-last-stand-2023/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_stand_2023",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2023,
                    festival: "Antenna Documentary Film Festival",
                    festivalURL: "https://antennafestival.org"
                )
            ]
        ),
        Film(
            title: "Breaking the Silence",
            year: 2022,
            director: "Sarah Johnson",
            description: "A groundbreaking documentary about whistleblowers in the tech industry.",
            posterURL: "breaking_silence_poster",
            imdbURL: "https://www.imdb.com/title/tt89012345/",
            letterboxdURL: "https://letterboxd.com/film/breaking-the-silence/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_the_silence",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2022,
                    festival: "Antenna Documentary Film Festival",
                    festivalURL: "https://antennafestival.org"
                )
            ]
        ),
        Film(
            title: "The Last Witness",
            year: 2021,
            director: "Michael Park",
            description: "A powerful documentary about the last surviving witnesses of historical events.",
            posterURL: "last_witness_poster",
            imdbURL: "https://www.imdb.com/title/tt90123456/",
            letterboxdURL: "https://letterboxd.com/film/the-last-witness/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_witness",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2021,
                    festival: "Antenna Documentary Film Festival",
                    festivalURL: "https://antennafestival.org"
                )
            ]
        ),
        Film(
            title: "Breaking Point",
            year: 2020,
            director: "Lisa Wong",
            description: "A compelling documentary about the global mental health crisis.",
            posterURL: "breaking_point_poster",
            imdbURL: "https://www.imdb.com/title/tt01234567/",
            letterboxdURL: "https://letterboxd.com/film/breaking-point/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_point",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2020,
                    festival: "Antenna Documentary Film Festival",
                    festivalURL: "https://antennafestival.org"
                )
            ]
        ),
        
        // Queer Screen Mardi Gras Film Festival Winners
        Film(
            title: "Pride and Prejudice",
            year: 2024,
            director: "Jordan Lee",
            description: "A modern retelling of Jane Austen's classic, set in contemporary Sydney's LGBTQ+ community.",
            posterURL: "pride_prejudice_poster",
            imdbURL: "https://www.imdb.com/title/tt12345678/",
            letterboxdURL: "https://letterboxd.com/film/pride-and-prejudice-2024/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/pride_and_prejudice_2024",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2024,
                    festival: "Queer Screen Mardi Gras Film Festival",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        Film(
            title: "The Last Dance",
            year: 2023,
            director: "Alex Chen",
            description: "A vibrant musical about a drag queen's final performance before retirement.",
            posterURL: "last_dance_poster",
            imdbURL: "https://www.imdb.com/title/tt23456789/",
            letterboxdURL: "https://letterboxd.com/film/the-last-dance-2023/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_dance_2023",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2023,
                    festival: "Queer Screen Mardi Gras Film Festival",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        Film(
            title: "Breaking Free",
            year: 2022,
            director: "Maria Rodriguez",
            description: "A powerful drama about a young person's journey to self-acceptance and coming out.",
            posterURL: "breaking_free_poster",
            imdbURL: "https://www.imdb.com/title/tt34567890/",
            letterboxdURL: "https://letterboxd.com/film/breaking-free/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_free",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2022,
                    festival: "Queer Screen Mardi Gras Film Festival",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        Film(
            title: "The Last Goodbye",
            year: 2021,
            director: "Sam Chen",
            description: "A touching story about a family's journey to acceptance after their child comes out as transgender.",
            posterURL: "last_goodbye_poster",
            imdbURL: "https://www.imdb.com/title/tt45678901/",
            letterboxdURL: "https://letterboxd.com/film/the-last-goodbye/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_goodbye",
            awards: [
                Award(
                    award: "Best Feature Film",
                    year: 2021,
                    festival: "Queer Screen Mardi Gras Film Festival",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        Film(
            title: "Breaking Barriers",
            year: 2020,
            director: "Taylor Wong",
            description: "A documentary exploring the history of LGBTQ+ rights in Australia.",
            posterURL: "breaking_barriers_poster",
            imdbURL: "https://www.imdb.com/title/tt56789012/",
            letterboxdURL: "https://letterboxd.com/film/breaking-barriers/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_barriers",
            awards: [
                Award(
                    award: "Best Documentary",
                    year: 2020,
                    festival: "Queer Screen Mardi Gras Film Festival",
                    festivalURL: "https://queerscreen.org.au"
                )
            ]
        ),
        
        // Europa! Europa Film Festival Winners
        Film(
            title: "The Last Train",
            year: 2024,
            director: "Sophie Dubois",
            description: "A French-German co-production that follows the journey of a family across Europe during the post-war period.",
            posterURL: "last_train_poster",
            imdbURL: "https://www.imdb.com/title/tt67890123/",
            letterboxdURL: "https://letterboxd.com/film/the-last-train/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_train",
            awards: [
                Award(
                    award: "Best European Film",
                    year: 2024,
                    festival: "Europa! Europa Film Festival",
                    festivalURL: "https://www.europafilmfestival.com.au"
                )
            ]
        ),
        Film(
            title: "The Silent Revolution",
            year: 2023,
            director: "Marco Rossi",
            description: "An Italian drama about a group of students fighting for political change in 1960s Europe.",
            posterURL: "silent_revolution_poster",
            imdbURL: "https://www.imdb.com/title/tt78901234/",
            letterboxdURL: "https://letterboxd.com/film/the-silent-revolution/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_silent_revolution",
            awards: [
                Award(
                    award: "Best European Film",
                    year: 2023,
                    festival: "Europa! Europa Film Festival",
                    festivalURL: "https://www.europafilmfestival.com.au"
                )
            ]
        ),
        Film(
            title: "Breaking the Ice",
            year: 2022,
            director: "Anna Schmidt",
            description: "A German comedy about cultural differences and friendship in modern Europe.",
            posterURL: "breaking_ice_poster",
            imdbURL: "https://www.imdb.com/title/tt89012345/",
            letterboxdURL: "https://letterboxd.com/film/breaking-the-ice/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_the_ice",
            awards: [
                Award(
                    award: "Best European Film",
                    year: 2022,
                    festival: "Europa! Europa Film Festival",
                    festivalURL: "https://www.europafilmfestival.com.au"
                )
            ]
        ),
        Film(
            title: "The Last Journey",
            year: 2021,
            director: "Pierre Dubois",
            description: "A French road movie about a family's journey across Europe during the pandemic.",
            posterURL: "last_journey_poster",
            imdbURL: "https://www.imdb.com/title/tt90123456/",
            letterboxdURL: "https://letterboxd.com/film/the-last-journey/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/the_last_journey",
            awards: [
                Award(
                    award: "Best European Film",
                    year: 2021,
                    festival: "Europa! Europa Film Festival",
                    festivalURL: "https://www.europafilmfestival.com.au"
                )
            ]
        ),
        Film(
            title: "Breaking Free",
            year: 2020,
            director: "Maria Schmidt",
            description: "A Spanish drama about a young woman's journey to independence in modern Europe.",
            posterURL: "breaking_free_poster",
            imdbURL: "https://www.imdb.com/title/tt01234567/",
            letterboxdURL: "https://letterboxd.com/film/breaking-free/",
            rottenTomatoesURL: "https://www.rottentomatoes.com/m/breaking_free",
            awards: [
                Award(
                    award: "Best European Film",
                    year: 2020,
                    festival: "Europa! Europa Film Festival",
                    festivalURL: "https://www.europafilmfestival.com.au"
                )
            ]
        )
    ]
} 